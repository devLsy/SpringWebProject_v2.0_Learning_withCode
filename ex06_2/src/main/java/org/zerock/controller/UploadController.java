package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.accept.HeaderContentNegotiationStrategy;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import oracle.jdbc.proxy.annotation.GetProxy;

@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {

		log.info("upload form");

	}

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {

		String uploadFolder = "C:\\dev\\private\\upload\\tmp";

		for (MultipartFile multipartFile : uploadFile) {

			log.info("----------------------------------------");
			log.info("upload File Name: " + multipartFile.getOriginalFilename());
			log.info("upload File Size: " + multipartFile.getSize());

			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			log.info("saveFile: " + saveFile);

			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {

		log.info("upload ajax");
	}

//	@PostMapping("/uploadAjaxAction")
//	public void uploadAjaxPost(MultipartFile[] uploadFile) {
//		
//		log.info("update ajax post~~~~~~~~~~~!!");
//		
//		String uploadFolder = "C:\\dev\\private\\upload\\tmp";
//		
//		for(MultipartFile multipartFile : uploadFile) {
//			
//			log.info("-----------------------------------------");
//			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
//			log.info("Upload File Size : " + multipartFile.getSize());
//			
//			String uploadFileName = multipartFile.getOriginalFilename();
//			
//			File saveFile = new File(uploadFolder, uploadFileName);
//			
//			try {
//					multipartFile.transferTo(saveFile);
//			} catch (Exception e) {
//					log.error(e.getMessage());
//			}
//		}
//	}

	private String getFolder() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		log.info("date: " + date);
		String str = sdf.format(date);

//		log.info("str: " + str);
		return str.replace("-", File.separator);
//		return str;
	}

	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("contentType: " + contentType);
			return contentType.startsWith("image");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/* 년월일 폴더 생성 */
//	@PostMapping("/uploadAjaxAction")
//	public void uploadAjaxPost(MultipartFile[] uploadFile) {
//		
//		String uploadFolder = "C:\\dev\\private\\upload\\tmp\\";
//		
//		File uploadPath = new File(uploadFolder, getFolder());
//		log.info("upload Path: " + uploadPath);
//		
//		if(uploadPath.exists() == false) {
//			uploadPath.mkdirs();
//		}
//		
//		for(MultipartFile multipartFile : uploadFile) {
//			
//			log.info("--------------------------------------------");
//			log.info("upload File Name: " +multipartFile.getOriginalFilename());
//			log.info("upload File Size: " + multipartFile.getSize() + "MB");
//			
//			String uploadFileName = multipartFile.getOriginalFilename();
//			
//			File saveFile = new File(uploadPath, uploadFileName);
//			
//			try {
//				
//				multipartFile.transferTo(saveFile);
//			} catch (Exception e) {
//				log.error(e.getMessage());
//			}
//		}
//	}

	/* UUID 적용 */
//	@PostMapping("/uploadAjaxAction")
//	public void uploadAjaxAction(MultipartFile[] uploadFile) {
//		
//		String uploadFolder = "C:\\dev\\private\\upload\\tmp\\";
//		
//		
//		File uploadPath = new File(uploadFolder, getFolder());
//		log.info("uploadPath: " + uploadPath);
//		
//		if(uploadPath.exists() == false) {
//			uploadPath.mkdirs();
//		}
//		
//		for(MultipartFile multipartFile : uploadFile) {
//			
//			log.info("--------------------------------------------");
//			log.info("uploadFile Name: " + multipartFile.getOriginalFilename());
//			log.info("uploadFile Size: " + multipartFile.getSize() + "MB");
//			
//			String uploadFileName = multipartFile.getOriginalFilename();
//			
//			UUID uuid = UUID.randomUUID();
//			log.info("uuid: " + uuid);
//			
//			uploadFileName = uuid.toString() + "_" + uploadFileName;
//			log.info("uploadFileName: " + uploadFileName);
//			
//			File saveFile = new File(uploadPath, uploadFileName);
//			
//			try {
//				multipartFile.transferTo(saveFile);
//			} catch (Exception e) {
//				log.error(e.getMessage());
//			}
//			
//		}
//	}

	/* 업로드 파일이 이미지면 섬네일 생성 */
//	@PostMapping("/uploadAjaxAction")
//	public void uploadAjaxAction(MultipartFile[] uploadFile) {
//		
//		String uploadFolder = "C:\\dev\\private\\upload\\tmp\\";
//		
//		File uploadPath = new File(uploadFolder, getFolder());
//		log.info("uploadPath: " + uploadPath);
//		
//		if(uploadPath.exists() == false) {
//			uploadPath.mkdirs();
//		}
//		
//		for(MultipartFile multipartFile : uploadFile) {
//			log.info("----------------------------------------------");
//			log.info("uploadFileName : " + multipartFile.getOriginalFilename());
//			log.info("uploadFileSize: " + multipartFile.getSize());
//			
//			String uploadFileName = multipartFile.getOriginalFilename();
//			
//			UUID uuid = UUID.randomUUID();
//			uploadFileName = uuid.toString() + "_" + uploadFileName;
//			
//			try {
//				File saveFile = new File(uploadPath, uploadFileName);
//				multipartFile.transferTo(saveFile);
//				
//				if(checkImageType(saveFile)) {
//					 FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
//					 Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
//					thumbnail.close();
//				}	
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			
//		}
//		
//	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		String uploadFolder = "C:\\dev\\private\\upload\\tmp\\";

		String uploadFolderPath = getFolder(); 
		
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("1. uploadPath: " + uploadPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}	

		for (MultipartFile multipartFile : uploadFile) {

			AttachFileDTO attachFileDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			long fileSize = multipartFile.getSize();
			log.info("fileSize: " + fileSize);
			attachFileDTO.setFileName(uploadFileName);
			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadFolderPath, uploadFileName);
				multipartFile.transferTo(saveFile);

				attachFileDTO.setUuid(uuid.toString());
				attachFileDTO.setUploadPath(uploadFolderPath);

				if (checkImageType(saveFile)) {
					attachFileDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					log.info("2. uploadPath: " + uploadPath);
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				list.add(attachFileDTO);
				log.info("list: " + list);

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("fileName: " + fileName);

		File file = new File("c:\\dev\\private\\upload\\tmp\\" + fileName);

		log.info("file: " + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));
			log.info("header: " + header);
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			log.info("result: " + result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	@GetMapping(value="/download" , produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource>downloadFile(@RequestHeader("User-Agent")String userAgent, String fileName){
		
		 Resource resource = new FileSystemResource("c:\\dev\\private\\upload\\tmp\\" + fileName);
		 
		 if(resource.exists() == false) {
			 return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		 }
		 
		 String resourceName = resource.getFilename();
		 log.info("resourceName: " + resourceName);
		 
		 // remove UUID
		 String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		 log.info("resourceOriginalName: " + resourceOriginalName);
		
		 HttpHeaders headers = new HttpHeaders();
		 log.info("userAgent: " + userAgent);
		 
		 try {
			 String downloadName = null;
			 
			 if(userAgent.contains("Trident")) {
				 log.info("IE browser");
				 downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", "");
			 
			 } else if(userAgent.contains("Edge")) {
				 log.info("Edge browser");
				 downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				 log.info("Edge Name: " + downloadName);
			 
			 } else {
				 log.info("chrome browser");
				 downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			 }
			 
			 headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			 
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		 return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		
		log.info("deleteFile: " + fileName);
		
		File file;
		
		try {
			file = new File("c:\\dev\\private\\upload\\tmp\\" + URLDecoder.decode(fileName, "UTF-8"));
			log.info("1. file: " + file);
			file.delete();
			
			if(type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName: " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	

}
