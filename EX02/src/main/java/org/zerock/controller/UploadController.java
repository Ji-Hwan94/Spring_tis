package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\upload";

		for(MultipartFile multipartFile : uploadFile) {
			log.info("===============================");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename()); // 파일명
			log.info("Upload File Size: " + multipartFile.getSize()); // 파일 사이즈
			
										// 파일 경로와 파일 이름
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile); // 파일업로드
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyy//MM//dd");
		
		Date date = new Date();
		String str = sdf.format(date);
		
		//return str.replace("-", File.separator);
		return str;
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@PostMapping(value = "/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();
		
		// 폴더 생성
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); // 폴더를 연속적으로 만들어야한다.
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename(); 
			
			
			// 인터넷익스플로어는 파일 경로을 가지고 있기 때문에 substring을 사용하여, 경로를 제외한 파일 이름을 가져온다.('\\'을 찾아서 파일명만 substring으로 구한다.)
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); 
			attachDTO.setFileName(uploadFileName);
						
			UUID uuid = UUID.randomUUID(); // uuid를 구한다. 같은 파일 중복 방지
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
  			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
			
				// 이미지이면 썸네일 생성(일반파일은 썸네일이 생성되지 않는다.)
				if(checkImageType(saveFile)) {
					
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100); // 원본, 썸네일, 썸네일 사이즈(가로, 세로)
					
					thumbnail.close();
				}
				
				list.add(attachDTO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	// 썸네일 이미지를 보여준다.
	@GetMapping("/display")
	@ResponseBody    // 이미지를 byte로 처리해서 클라이언트에게 보낸다.
	public ResponseEntity<byte[]> getFile(String fileName){
		File file = new File("c:\\upload\\" + fileName);
		
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK); // byte 배열 복사
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
