<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-05
  Time: 오후 8:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    Connection con = null;

    String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
    String user_name = "root"; //  MySQL 서버 아이디
    String password = "pw1234"; // MySQL 서버 비밀번호

//   1.드라이버 로딩
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("connect success!!!!");
    } catch (ClassNotFoundException e) {
        System.err.println(" !! <JDBC Driver Error> Driver load Error 오류오류: " + e.getMessage());
        e.printStackTrace();
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(url, user_name, password);
        System.out.println("Connect Success");
    } catch(SQLException e) {
        System.err.println("con Error:" + e.getMessage());
        e.printStackTrace();
    }

    Statement statement = con.createStatement();
    ResultSet resultSet = statement.executeQuery("select * from member");

    resultSet.next();

//  String name = resultSet.getString("name");
//  String email = resultSet.getString("email");
//  int num = resultSet.getInt("num");
//  String pw = resultSet.getString("pw");

//  System.out.println(name);

    // 3.해제
    try {
        if(con != null)
            con.close();
        statement.close();
        resultSet.close();
    } catch (SQLException e) {}
%>
<html>
<head>
    <title>board_write</title>
</head>
<h1>게시판-등록</h1>

<script type="text/javascript">
    function gourl(url){
        location.href=url;
    }

    // 유효성 체크
    function BoardWriteChk() {
        let cate = document.getElementById('category');
        let wri = document.getElementById('writer');
        let pass = document.getElementById('password');
        let tit = document.getElementById('title');

        if (cate.value == "" || cate.value == null) {
            alert("카테고리를 선택하세요.");
            cate.focus();
            return false;
        }

        if (wri.value == "" || wri.value == null) {
            alert("작성자명을 입력하세요.");
            wri.focus();
            return false;
        }

        if (pass.value == "" || pass.value == null) {
            alert("비밀번호를 입력하세요.");
            pass.focus();
            return false;
        }

        if (tit.value == "" || tit.value == null) {
            alert("제목을 입력하세요.");
            tit.focus();
            return false;
        }
        tit.submit();
    }
</script>

<body>
<form name = "board_write" action="board_write_ok.jsp" method="post" onsubmit="return BoardWriteChk();">
    <table>
        <tbody class="classification">
        <tr>
            <th>카테고리</th>
            <td><select id="category" name="category">
                <option value="Java">Java</option>
                <option value="JavaScript">JavaScript</option>
                <option value="Database">Database</option>
            </select></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>
                <input type="text" id="writer" name="writer" maxlength="50">
            </td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="text" placeholder="비밀번호" id="password" name="password" maxlength="50">
                <input type="text" placeholder="비밀번호 확인"></td>
        </tr>
        <tr>
            <th>제목</th>
            <td><input type="text" id="title" name="title" maxlength="50"></td>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="2"><textarea name="content" id="content" cols="75" rows="15"></textarea></td>
        </tr>
        <tr>
            <th>파일 첨부</th>
            <td> </td>
        </tr>
        </tbody>
    </table>
    <p>
        <input type="button" value="저장" onclick="gourl('board_list.jsp')">
        <%--        <input type="button" value="취소" onclick="gourl('board_list.jsp')">--%>
    </p>
</form>
</body>
</html>
