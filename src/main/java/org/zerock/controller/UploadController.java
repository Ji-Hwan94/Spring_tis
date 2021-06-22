package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	@GetMapping("/uploadForm")
	public void uploadForm() {}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile,Model model){
		log.info("/uploadFormAction");
		String uploadFolder="c:\\upload";
		for(MultipartFile multipartFile : uploadFile) {
			File saveFile=new File(uploadFolder,multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}		
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {}
	
	
	private String getFolder() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy\\MM\\dd");
		Date date=new Date();
		String str=sdf.format(date);
		//return str.replace("-",File.separator);
		return str;
	}
	
	private boolean checkImageType(File file) {
		try {
			// 확장자 명을 지울 경우 이미지를 인식하지 못한다.
			// String contentType=Files.probeContentType(file.toPath());
			
			// tika는 확장자 이름이 없어도 인식이 가능하다.
			String contentType = new Tika().detect(file.toPath());
			log.info(contentType);
			return contentType.startsWith("image");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}
	
	
	@PostMapping(value="/uploadAjaxAction",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		List<AttachFileDTO> list=new ArrayList<>();
		
		String uploadFolder="c:\\upload";
		String uploadFolderPath=getFolder();
		File uploadPath=new File(uploadFolder,uploadFolderPath);
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			AttachFileDTO attachDTO=new AttachFileDTO();
			
			String uploadFileName=multipartFile.getOriginalFilename();
			log.info(uploadFileName);
			// IE에서는 c:\\users\\pic.jpg 형식으로 UploadFileName이 구해지므로,
			// 마지막 '\\'를 찾아서 파일명만 substring으로 구함
			uploadFileName=uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			attachDTO.setFileName(uploadFileName);//파일명
			
			UUID uuid=UUID.randomUUID();
			uploadFileName=uuid.toString()+"_"+uploadFileName;
			
			attachDTO.setUuid(uuid.toString()); //UUID
			attachDTO.setUploadPath(uploadFolderPath); // 2021\\06\\16		
			
			File saveFile=new File(uploadPath,uploadFileName);
			try {
				multipartFile.transferTo(saveFile);//원본파일
				
				//이미지이면 썸네일 생성
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true); //image여부 
					FileOutputStream thumbnail=new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100, 100);
					thumbnail.close();
				}
				// list에 추가
				list.add(attachDTO);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	//파일을 byte[]형태로 보냄
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		File file=new File("c:\\upload\\"+fileName);
		ResponseEntity<byte[]> result=null;
		try {
			HttpHeaders header=new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result=new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//download
	@GetMapping(value="/download",produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent,String fileName){
		Resource resource=new FileSystemResource("c:\\upload\\"+fileName);
		
		//파일이 존재하지 않는 경우
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName=resource.getFilename();
		log.info(resourceName);
		
		String resourceOriginalName=resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders headers=new HttpHeaders();
		try {
			String downloadName=null;
			log.info("userAgent : "+userAgent);
			//IE
			if(userAgent.contains("Trident") || userAgent.contains("MSIE")) {
				log.info("IE");
				downloadName=URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+", " ");
			}else {
				log.info("Edge or Chrome");
				downloadName=new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}
			headers.add("Content-Disposition", "attachment; filename="+downloadName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);
		File file;
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();//썸네일삭제, 일반파일삭제
			if (type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");//s_를 지우면 원본파일명이 됨
				log.info("largeFileName: " + largeFileName);
				file = new File(largeFileName);
				file.delete();//원본삭제
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}
	
}	
