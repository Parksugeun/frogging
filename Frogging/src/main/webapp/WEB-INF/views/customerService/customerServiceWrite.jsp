<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="//cdn.ckeditor.com/4.19.1/full/ckeditor.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" 
       integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<style>
#cke_customerService_content{
	height:100%;
}
.cke_screen_reader_only {
	position: inherit;
}
/* button */
/*.btn {font-family:'malgunbd';display:inline-block;padding:3px 20px 6px 20px;margin:0;border:1px solid #aaa;cursor:pointer;color:#333;border-radius:2px;vertical-align:middle;font-size:13px;letter-spacing:-1px;line-height:normal;background-color:#feffff;text-decoration:none;}*/
.btn {    
	height: 35px;
    width: 90px;
    background-color: #2fb86a;
    border : 1px solid white;
    border-radius:5px;
    color: white;
    font-weight: bold;
    font-size: 18px;
    margin: 0 2px;
    font-family: 'Noto Sans KR', sans-serif;
    }
.btn.black {border-color:#191919;color:#fff;background-color:#333;text-decoration:none;}
</style>
<script type="text/javascript">


    $(document).ready(function(){        
        CKEDITOR.replace("customerService_content");
        
    	$("#customerServiceForm").submit(function(){
    		if($("#customerService_subject").val()==""){
    			alert("????????? ???????????????.");
    			return false;
    		}
    		if(CKEDITOR.instances.content.getData()==""){
    			alert("???????????? ???????????????.");
    			return false;
    		}
    		return true;
    	});
    });

    
</script>
</head>
<body>
    <div class="p_container">
        <div class="inner">        
           <br/> <h1 class="p_title">???????????? ?????????</h1><br/>
            <form id="customerServiceForm" name="customerServiceForm" method="post" action="/customerService/customerServiceWriteOk">
                <table class="table02" style="height:600px; width:100%;">
                <caption><strong><span class="t_red">*</span> ????????? ???????????? ???????????????.</strong></caption>
                    <colgroup>
                        <col width="20%">
                        <col width="*">
                    </colgroup>
                    <tbody id="tbody">
                        <tr>
                            <th>??????<span class="t_red">*</span></th>
                            <td><input id="customerService_subject" name="subject" value="" class="tbox01"/></td>
                        </tr>
                        <!--  
                        <tr>
                            <th>?????????<span class="t_red">*</span></th>
                            <td><input id="customerService_writer" name="customerService_writer" value="" class="tbox01"/></td>
                        </tr>-->
                        <tr>
                            <th>??????<span class="t_red">*</span></th>
                            <td><textarea id="customerService_content" name="content" class="textarea01" style="background-color:pink; height:100%;"></textarea></td>
                        </tr>
                    </tbody>
                    
                    
                </table>
				 <div class="btn_right mt15" style="width:80%; margin:0 auto; float:right;">
		                <button type="button" class="btn black mr5" onclick="location.href='/customerService/customerServiceList'">????????????</button>
		                <input type="submit" class="btn black" value="????????????"/>
				 </div> 
            </form>
           
        </div>
    </div>
</body>
</html>