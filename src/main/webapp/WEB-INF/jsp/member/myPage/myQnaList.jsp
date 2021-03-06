<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<style type="text/css">

@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
a{
   color: #000;
   text-decoration: none;	
}
#main-container{
   width:1100px;
   align:center;
   font-family: 'Nanum Gothic';
   clear:both;
}

#content{
	width:1120px;
	margin-left:50px;
}

button {
  background:none;
  border:0;
  outline:0;
  cursor:pointer;
}
.tab_menu_container {
  display:flex;
}
.tab_menu_btn {
  width:90px;
  height:40px;
  transition:0.3s all;
}
.tab_menu_btn.on {
  border-bottom:2px solid #df0000;
  font-weight:700;
  color:#df0000;
}
.tab_menu_btn:hover {
  color:#df0000;
}
.tab_menu_container{
	float:right;
	font-family: 'Nanum Gothic';
	margin-bottom:50px;
}
.tab_wrap{
	clear:both;
}

</style>

</head>
<body>
<div>
<div id="content">

  <div class="tab_wrap">
  <div class="tab_menu_container">
    <a href="accountDetail"><button class="tab_menu_btn" type="button">회원정보</button></a>
    <a href="pwModifyForm"><button class="tab_menu_btn" type="button">비밀번호 변경</button></a>
    <a href="deleteAccount"><button class="tab_menu_btn" type="button">회원탈퇴</button></a>
    <a href="reportList"><button class="tab_menu_btn" type="button">내 신고 내역</button></a>
    <a href="qnaList"><button class="tab_menu_btn on" type="button">내 문의 내역</button></a>
  </div>
  </div>

   <div id="main-container">
		
		<h2>Q&A 게시판</h2><br>
		
	<table align="center" class="table table-striped table-condensed">
	
		<colgroup>
			<col width="10%" />
			<col width="*" />
			<col width="15%" />
			<col width="25%" />  
			<col width="10%" />
		</colgroup>  
		<caption><h2>문의게시판</h2></caption>
		<thead>
			<tr>
				<th scope="col">글번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">답글여부</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	
	<div id="PAGE_NAVI" align="center"></div>
	<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />

	<br />

	</div>
    <br/>
</div>
</div>
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function() {
			 fn_selectBoardList(1);

			$("a[name='title']").on("click", function(e) { //제목 
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
		});
	
		function fn_openBoardDetail(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/myPage/qnaDetail' />");
			comSubmit.addParam("QNA_NUM", obj.parent().find("#QNA_NUM").val());
			comSubmit.submit();
		}
	    function fn_selectBoardList(pageNo) {
			var comAjax = new ComAjax();
			 var id="${session_MEM_ID}"
			comAjax.setUrl("<c:url value='/myPage/qnaListPaging'/>");
			comAjax.setCallback("fn_selectBoardListCallback");
			comAjax.addParam("id", id); 
			comAjax.addParam("PAGE_INDEX", pageNo);
			comAjax.addParam("PAGE_ROW", 15);
			comAjax.ajax();
		}

		function fn_selectBoardListCallback(data) {
			var total = data.TOTAL;
			var body = $("table>tbody");
			body.empty();
			if (total == 0) {
				var str = "<tr align=\"center\">" + "<td colspan='6'>조회된 결과가 없습니다.</td>"
						+ "</tr>";
				body.append(str);
			} else {
				var params = {
					divId : "PAGE_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					recordCount : 15,
					eventName : "fn_selectBoardList"
					
				};
				gfn_renderPaging(params);

				var str = "";
				$.each(
								data.list,
								function(key, value) {
									str     += "<tr style=\"text-align: center\">"
											+ "<td>"
											+ value.QNA_NUM
											+ "</td>"
											+ "<td class='title'>"
											+ "<a href='#this' name='title'>"
											+ value.QNA_TITLE
											+ "</a>"
											+ "<input type='hidden' id='QNA_NUM' value=" + value.QNA_NUM + ">"
											+ "</td>" + "<td>" + value.MEM_ID
											+ "</td>" + "<td>" + new Date(value.QNA_DATE).toLocaleString()
											+ "</td>" + "<td>" + value.QNA_YORN
											+ "</td>" + "<td>" + value.QNA_COUNT
											+ "</td>" + "</tr>";
								});
				body.append(str);

				/* $("a[name='title']").on("click", function(e) { //제목
					e.preventDefault();
					fn_openBoardDetail($(this));
				}); */
			}
		} 
	</script>
</body>
</html>