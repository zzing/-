<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="unnamed_index" %>
<!DOCTYPE html>
<html>
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../Scripts/common.js"></script>
    <title>★게시글 목록★</title>
    <script>
        var is_sending = false;

        $(document).ready(function () {
          // 페이지가 load될때 전체 리스트 조회 
          ajaxList();
          $('.tbList tbody').on("click", "tr", fnDetailView);
        });

        function ajaxList() {
            var callback = function (response) {
              //$('.tbList tbody').empty();
		        if (!isEmpty(response)) {
			        //받아온 값에 대한 처리
			        //목록인 경우
			        $.each(response, function (key, value) {
                var boardNo = value.Board_No;
                var boardWriter = value.Board_Write;
                var boardContent = value.Board_Title;
                // fnOracleDateFormatConverter : 데이터를 원하는 포맷으로 변환시켜주는 함수
                var regDate = fnOracleDateFormatConverter(value.Board_RegDate);
                var boardSeq = value.Svid_Board;

                var $html='<tr><td>'
                    + boardNo +
                    '<input type="hidden" value="'
                    + boardSeq +
                    '" /></td ><td>'
                    + boardWriter +
                    '</td><td class="leftAlign">'
                    + boardContent +
                    '</td><td>'
                    + regDate +
                    '</td></tr >'

                $('.tbList tbody').append($html);

			        });

		        } else {
			        alert("오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
		        }
		        return false;
	        };
          
          var param = {
              Keyword: "",
              Target: "Title",
              PageNo: 1,
              PageSize: 20,
              BoardGubun: 13,
              BoardUser: "1f0d0d1d-770c-41a6-a8fd-8891d544befe",
              Method: "GetBoardList"
          };

	        var beforeSend = function () {
		        is_sending = true;
	        }
	        var complete = function () {
		        is_sending = false;
	        }
	        if (is_sending) return false;

	        JqueryAjax("Post", "./Handler/S_Handler.ashx", true, false, param, "json", callback, beforeSend, complete, true, '1f0d0d1d-770c-41a6-a8fd-8891d544befe');
        }
        
        function fnDetailView(e) {
            e.preventDefault();
            var currentTarget = e.currentTarget;
            var Svid = $(currentTarget).find('input[type="hidden"]').val();
            // 해당 글의 sequence를 넘겨서 상세 페이지로 이동
            location.href = './detail.aspx?Svid=' + Svid;
            }
    </script>
    <link rel="stylesheet" href="test.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>게시판 목록</h1>
            <table class="tbList">
                <caption>테스트 테이블</caption>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>내용</th>
                        <th>등록날짜</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <a href="write.aspx" class="btnWrite">글작성</a>
        </div>
    </form>
</body>
</html>
