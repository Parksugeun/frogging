// 전역 변수 
var partyname_checked=false;
var new_name=false;
var party_no;

// ------------------ 클럽 삭제하기/신청 취소하기 -------------------
function deleteClub(no) {
	if(confirm("이 모임을 삭제하시겠습니까?")){
		location.href = "/club/deleteClub?no="+no;
	}
}
function leaveClub(no) {
	if(confirm("이 모임 참여를 취소하시겠습니까?")){
		location.href = "/club/leaveClub?no="+no;
	}
}
//---------------- 파티이름 중복검사 ---------------
function checkPartyname() {
	$(function(){
		$.ajax({
			type : "post",
			url: "/club/checkPartyname",
			data: {partyname: $('#k_party_set_party_name').val()},
			success: function(result){
				if (result=="yes"){
					alert("모임명 사용가능");
					partyname_checked = true;
				}else{
					alert("모임명 사용 불가능");
					partyname_checked = false;
					$('#k_party_set_party_name').val('');
				}
			}, error:function(e){
				console.log(e.responseText);
			}
		});
		
	})
}

//----------------- 클럽  유효성 검사 --------------------
$(function(){
	//partyname onchange event -> new_name = true;
	//meeting_time : MM-dd  hh:mm :상태 

	$('.k_party_frm_submit').click(function(){
		if($('#k_party_set_party_name').val() == ""){
			alert("모임명을 입력해주세요");
			return false;
		}
		// if(!partyname_checked && new_name){
		// 	alert("모임명 중복검사를 해주세요");
		// 	return false;
		// }

		if($('#k_party_set_party_number').val() == ""){
			alert("모집인원을 선택해주세요");
			return false;
		}
		if($('#k_party_set_party_number').val()<3 || $('#k_party_set_party_number').val()>12){
			alert("선택가능한 모집인원은 3 ~ 12명 사이입니다.");
			return false;
		}
		if($('#k_party_set_meeting_time').val() == ""){
			alert("모임 일시를 선택해주세요");
			return false;
		}
		if($('#k_party_set_meeting_place').val() == ""){
			alert("만남 장소를 입력해주세요");
			return false;
		}
		alert("submit");
		$("#k_editPartyFrm").submit();
	});
});

// --------------------------- member manage modal ----------------------
var arr = [];
function modal_data(no) {
	$(function(){
		var url = "/club/getMemberDetail";
		var params = {no:no};
		party_no = no;

		$.ajax({
			url: url,
			data: params,
			success: function(result){
				console.log(result);

				$('.modal_title').html('[ '+result[0].partyname+' ] 참여 멤버');
				var tag='<li class="k_my_list_head"><span>파티번호</span></li><li class="k_my_list_head"><span>아이디</span></li><li class="k_my_list_head"><span>닉네임</span></li>';
				tag += '<li class="k_my_list_head"><span>상태</span></li><li class="k_my_list_head"><span>확인</span></li>';
				for (let index = 0; index < result.idx; index++) {
					tag += "<li><span>"+result[index].party_no+"</span></li>";
					tag += "<li><span>"+result[index].user_id+"</span></li>";
					tag += "<li><span>"+result[index].nickname+"</span></li>";
					arr[index] = result[index].user_id;

					if (result[index].join_status == 4){//관리자
						tag += "<li><span>관리자</span></li>";
						tag += "<li><span>-</span></li>";
					} else if (result[index].join_status == 3 ){//퇴장
						tag += "<li><span>퇴장 처리</span></li>";
						tag += "<li><span>-</span></li>";
					} else if (result[index].join_status == 2 ){//신청 - 거절
						tag += "<li><span>거절 처리</span></li>";
						tag += "<li><span>-</span></li>";
					} else if (result[index].join_status == 1 ){//신청 - 수락
						tag += "<li><span>수락 완료</span></li>";
						tag += "<li class='k_btn'><span><button id='k_manage_3_"+index+"' onmouseover='k_btn_3("+index+");'>퇴장</button></span></li>";
					}else if (result[index].join_status == 0 ){
						tag += "<li><span>수락 대기</span></li>";
						tag += "<li class='k_btn'><span><button id='k_manage_1_"+index+"' onmouseover='k_btn_1("+index+");'>수락</button>";
						tag += "<button id='k_manage_2_"+index+"' onmouseover='k_btn_2("+index+");'>거절</button></span></li>";
					} else{
						tag += "<li><span>기타</span></li>";
						tag += "<li><span>-</span></li>";
					}
				}

				$('.k_party_manage_infos').html(tag);
			}, error:function(e){
				console.log(e.responseText);
			}
		});



	})		
}

// ---------------- member manage button ------------------
function k_btn_1(no) { //수락
	
	$(function(){
		var userid = arr[no];
		console.log("in/"+no+"/"+userid);
		var name = "k_manage_1_" + no;
		$("#"+name).css('color', 'green');
		$("#"+name).on({
			mouseenter: function() {
				console.log("in");
				$(this).css('color', 'green');
			}, mouseleave: function() {
				$(this).css('color', 'black');
			}, click: function(){
				if(confirm("수락하시겠습니까?")){
					location.href= "/club/allowClub?partyno="+party_no+"&userid="+userid;
				}
			}
		});
	});
}
function k_btn_2(no) { //거절
	$(function(){
		var userid = arr[no];
		console.log("in/"+no+"/"+userid);
		var name = "k_manage_2_" + no;
		$("#"+name).css('color', 'green');
		$("#"+name).on({
			mouseenter: function() {
				console.log("in");
				$(this).css('color', 'green');
			}, mouseleave: function() {
				$(this).css('color', 'black');
			}, click: function(){
				if(confirm("이 멤버의 요청을 거절하겠습니까?")){
					var reason = prompt("거절 사유를 입력하세요.\n1)부적절한 언행\n2)신청 마감\n3)기타 사유");
					//alert(reason);
					if (reason>0 && reason<4){
						location.href= "/club/refuseClub?partyno="+party_no+"&userid="+userid+"&reason="+reason;
					}
				}
			}
		});
	});
}
function k_btn_3(no) { //퇴출
	$(function(){
		var userid = arr[no];
		console.log("in/"+no+"/"+userid);
		var name = "k_manage_3_" + no;
		$("#"+name).css('color', 'green');
		$("#"+name).on({
			mouseenter: function() {
				console.log("in");
				$(this).css('color', 'green');
			}, mouseleave: function() {
				$(this).css('color', 'black');
			}, click: function(){
				if(confirm("이 멤버의 요청을 거절하겠습니까?")){
					var reason = prompt("거절 사유를 입력하세요.\n1)부적절한 언행\n2)신청 마감\n3)기타 사유");
					if (reason>0 && reason<4){
						location.href= "/club/refuseClub?partyno="+party_no+"&userid="+userid+"&reason="+reason;
					} 
				}
			}
		});
	});
}


$(function(){
	//--------------- date picker에서 오늘 이후 선택 처리 ----------

			//날짜입력창 최소 선택: 현재날짜 
		var today = new Date();
		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		var dateString = year + '-' + month + '-' + day+" 00:00";
		$('#k_party_set_party_meeting_time').attr('min', dateString);
		//console.log("최소"+dateString);

			//날짜 최대 입력값 제한 : 2개월 이후 
		var today = new Date();
		today.setMonth(today.getMonth() + 2);
		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		var dateString = year + '-' + month + '-' + day+" 00:00";
		$('#k_party_set_party_meeting_time').attr('max', dateString);
		//console.log("최대"+dateString);
	})