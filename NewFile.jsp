<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
 
<%
    String syscontext = request.getContextPath();
 
%>
 
<% 
  String path = request.getContextPath(); 
  String basePath = request.getScheme() + "://"
      + request.getServerName() + ":" + request.getServerPort() 
      + path; 
   
  String sessionid = session.getId();
   
%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript" src="js/jquery-1.7.2.min.js"></script>
<link href="uploadify3.0/uploadify.css" rel="stylesheet" type="text/css" />
<script src="uploadify3.0/jquery.uploadify.min.js" type="text/javascript"></script>
 
<!-- 注意我使用的jquery uploadify版本-->
 
 
<script type="text/javascript">
//用来计算上传成功的图片数
var successCount = 1;
 
$(function() {
    var uploadUrl = '<%=basePath%>/uploadImg;jsessionid=<%=sessionid%>?Func=uploadwallpaper2Dfs';
     
    var swfUrl2 = "<%=basePath%>/html/uploadify3.0/uploadify.swf";
  $('#file_upload').uploadify({
    'swf'   : swfUrl2,
    'uploader' : uploadUrl,
    // Put your options here
    'removeCompleted' : false,
    'auto' : false,
    'method'  : 'post',
    'onUploadSuccess' : function(file, data, response) {
      add2SuccessTable(data);
    }
  });
});
 
 
 
/**
 * 将成功上传的图片展示出来
 */
function add2SuccessTable(data){
    var jsonObj = JSON.parse(data);
    for(var i =0; i < jsonObj.length; i++){
        var oneObj = jsonObj[i];
        var fileName = oneObj.fileName;
        var imgUrl = oneObj.imgUrl;
         
        var td_FileName = "<td>"+fileName+"</td>";
        var td_imgUrl = "<td><img width='150' src='"+imgUrl+"'></img></td>";
        var oper = "<td><input type='button' value='删除' onclick='deleteRow("+successCount+")'/></td>";
        var tr = "<tr id='row"+successCount+"'>"+successCount+td_FileName+td_imgUrl+oper+"</tr>";
         
        $("#successTable").append(tr);
         
        successCount++;
    }
     
}
 
 
 
function deleteRow(i){
    $("#row"+i).empty();
    $("#row"+i).remove();
}
</script>
 
 
<title>Insert title here</title>
</head>
<body>
<input type="file" name="file_upload" id="file_upload" />
    <p> 
        <a href="javascript:$('#file_upload').uploadify('upload','*')">开始上传</a>  
        <a href="javascript:$('#file_upload').uploadify('cancel', '*')">取消所有上传</a>
    </p> 
<table id="successTable">
    <tr>
        <td>文件名</td>
        <td>图片</td>
        <td>操作</td>
    </tr>
</table>
</body>
</html>