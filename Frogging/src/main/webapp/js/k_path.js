
// 전역 변수 
const urlParams = new URL(location.href).searchParams;
var addr_section_1 = urlParams.get('addr_section_1');
var addr_section_2 = urlParams.get('addr_section_2');


console.log(addr_section_1);
console.log(addr_section_2);



var course_no;
var select_course_no;
var select_course_name;
var partyname_checked=false;



$(function(){
	$('#addr_section_1').val(addr_section_1).prop("selected",true);
	$('#addr_section_2').val(addr_section_2).prop("selected",true);
});

//------------------------- 코스 검색  -----------------------------
function searchPath() {
	$(function(){
		//------------------------- 경로 검색 (주소) -----------------------------
			$("#pathSearchForm").submit(function(){
				if($("#addr_section_2").val()==""){
					alert("주소 소분류 선택하세요.");
					return false;
				}
				return true;
			})

		});
}

//-------------------경로 세부 모달 내용 가져오기-------------------
function modal_data(no) {
	$(function(){
		
		course_no = no;
		//alert(no);
		//모달 비우기 

		var url = "/club/getPathDetail";
		var params = {no:no};
		console.log("코스번호:"+no);
		
		$.ajax({
			url: url,
			data: params,
			success: function(result){
				var path = result.path;
				let map_arr_view = [];
				let detail_arr_view = [];
				
				map_arr_view.push({
					course_no : 99999,
					course_name : path.course_name,
					distance : path.distance,
					time : path.time,
					type : path.type
				});
				console.log(map_arr_view);
				for(let i = 0; i < Object.keys(result).length-1; i++){
					detail_arr_view.push({
						course_no : 99999,
						waypoint : result[i].waypoint,
						lat : result[i].lat,
						log : result[i].log,
						addr : result[i].addr
					});
				}
				
				select_course_name = path.course_name;
				
				//세부 데이터 넣기
				$('#k_coursename>span').html(path.course_name);
				$('#k_startaddr>span').html(path.startaddr);
				$('#k_endaddr>span').html(path.endaddr);
				$('#k_time>span').html(path.time+" 분");
				$('#k_distance>span').html(path.distance+" km");
				$('#k_plog_total>span').html(path.plog_total+" 회");
				
				$('.k_path_map').attr('id', 'map_div_'+99999);
				mapLoad(map_arr_view, detail_arr_view);
				
				
				//alert(path.course_name);

			}, error:function(e){
				console.log(e.responseText);
			}
		});

	})
}
//----------------- 코스 선택 버튼 클릭 --------------------
function select_path() {
	if(confirm("이 경로를 선택하시겠습니까?")){
		//console.log("선택한 경로 번호: " + course_no);
		select_course_no = course_no;
		alert(select_course_name + " 선택완료");

		//선택한 파티 -> 폼
		$(function(){
			console.log('------');
			console.log(select_course_name);
			$("#k_party_set_course_no").val(select_course_no);
			$("#k_party_set_course_name").val(select_course_name);
		});
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
	$('.k_party_frm_submit').click(function(){
		if(!$('#k_party_set_agree').is(':checked')){
			alert("모임 가이드에 동의해주세요");
			return false;
		}
		if($('#k_party_set_party_name').val() == ""){
			alert("모임명을 입력해주세요");
			return false;
		}
		if(!partyname_checked){
			alert("모임명 중복검사를 해주세요");
			return false;
		}
		if($('#k_party_set_course').val() == ""){
			alert("코스를 선택해주세요");
			return false;
		}
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

		$("#k_party_set_frm").submit();
	});
});

//----------------- 주소 처리 --------------------
function changeAddr() {
	//대분류 바꿨을 때
	$(function(){
		//소분류 처리
		$.ajax({
			url: "/data/getAddr_2",
			data: {addr_1:$("#addr_section_1 option:selected").val()},
			success: function(result){				
				var tag = "";

				tag += "<option value=''>세부 선택</option>";
				for (let index = 0; index < result.idx; index++) {
					tag += "<option value='"+result[index].addr_section_2+"'>"+result[index].addr_section_2+"</option>";
					console.log(result[index].addr_section_2);
				}

				$("#addr_section_2").empty("");
				$("#addr_section_2").html(tag);
			}, error:function(e){
				console.log(e.responseText);
			}
		})
	});
}
