package org.zerock.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}

	// 11시 15분에 파일 삭제
	@Scheduled(cron="0 36 11 * * *")
	public void checkFiles() throws Exception{
		log.warn("===========================");
		log.warn("File check");
		
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		
		// 데이터 베이스에 저장된 파일과 폴더에 있는 파일이 동일하게 저장되어있는지 비교
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());
		
		fileList.stream().filter(vo -> vo.isFileType() == true).map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName())).forEach(p -> fileListPaths.add(p));
		
		log.warn("======================");
		
		// 어제 저장된 폴더에 있는 파일 확인
		fileListPaths.forEach(p -> log.warn(p));
		
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		
		// table에 있는 파일이, 실제 파일이 폴더에 있는어 있는가? 없는 경우 removeFiles 배열에 저장
		File [] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("======================");
		
		for(File file : removeFiles) {
			log.warn(file.getAbsoluteFile());
			
			// 비교 후 삭제
			file.delete();
		}
		
	}
	
}
