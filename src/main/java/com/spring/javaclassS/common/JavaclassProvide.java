package com.spring.javaclassS.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.AbstractView;

@Service
public class JavaclassProvide {
	
	@Autowired
	JavaMailSender mailSender;

	// urlPath에 파일 저장하는 메소드 : (업로드파일명, 저장할파일명, 저장할경로)
	public void writeFile(MultipartFile fName, String sFileName, String urlPath) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}
	
	public void deleteFile(String photo, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		File file = new File(realPath + photo);
		if(file.exists()) file.delete();
	}

	// 파일 이름 변경하기(중복방지를 위한 작업)
	public String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH)+1;
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR_OF_DAY);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		//fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}

	// 메일 전송하기(아이디찾기, 비밀번호 찾기)
	public String mailSend(String email, String title, String pwd) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String content = "";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 작성한 메세지들의 정보를 모두 저장시킨후 작업처리...
		messageHelper.setTo(email);			// 받는 사람 메일 주소
		messageHelper.setSubject(title);	// 메일 제목
		messageHelper.setText(content);		// 메일 내용
		
		// 메세지 보관함의 내용(content)에 , 발신자의 필요한 정보를 추가로 담아서 전송처리한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3> 임시비밀번호 : "+pwd+"</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>javaclass</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// 본문에 기재될 그림파일의 경로를 별도로 표시시켜준다. 그런후 다시 보관함에 저장한다.
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		messageHelper.addInline("main.jpg", file);
		
		// 메일 전송하기
		mailSender.send(message);
		
		return "1";
	}

	// PDF파일 처리를 위한 서비스
	/*
	public byte[] createPdf(String text) throws IOException {
    try (PDDocument document = new PDDocument()) {
      PDPage page = new PDPage();
      document.addPage(page);
      
      //Font font = Font.createFont(Font.TRUETYPE_FONT, this.getClass().getClassLoader().getResourceAsStream("fonts/NanumGothic-Bold.ttf"));
      // 나눔고딕 폰트를 로드합니다.
      //File fontFile = new File("fonts/NanumGothic.ttf");
      File fontFile = new File("fonts/NanumGothic-Bold.ttf");
      PDType0Font font = PDType0Font.load(document, fontFile);

      try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
        //contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
        contentStream.setFont(font, 12);
        contentStream.beginText();
        contentStream.newLineAtOffset(100, 700);
        contentStream.showText(text);
        contentStream.endText();
      }

      ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
      document.save(outputStream);
      return outputStream.toByteArray();
    }
	}
	*/
	/*
	public class DownloadView extends AbstractView {

		public DownloadView() {
			setContentType("application/octet-stream");
		}

		@Override
		protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			Assert.notNull(model, "model is null");

			Object o = model.get("download");
			Assert.notNull(o, "download file is empty");

			response.setContentType(getContentType());
			response.setHeader("Content-Transfer-Encoding", "binary");

			OutputStream out = response.getOutputStream();

			String fileName = null;
			InputStream is = null;
			File file = null;

		
			@SuppressWarnings("unchecked")
			HashMap<String, Object> map = (HashMap<String, Object>) model.get("download");
			file = (File) map.get("download");
			is = new FileInputStream(file);
			response.setContentLength((int) file.length());
			fileName = (String) model.get("fileName");
		
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\";");

			try {
				FileCopyUtils.copy(is, out);
			} finally {
				if (is != null) {
					try {
						is.close();
					} catch (IOException ex) {
					}
				}
			}
			
			out.flush();
		}
	}
	*/
}
