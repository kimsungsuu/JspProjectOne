<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-08
  Time: 오후 8:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import ="java.sql.*"%>

<%
        Connection con = null;

        String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
        String user_name = "root"; //  MySQL 서버 아이디
        String password_DB = "pw1234"; // MySQL 서버 비밀번호

        String num = request.getParameter("num");

//   1.드라이버 로딩
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("connect success!!!!");
        } catch (ClassNotFoundException e) {
            System.err.println(" !! <JDBC Driver Error> Driver load Error : " + e.getMessage());
            e.printStackTrace();
        }

        // 2.연결
        try {
            con = DriverManager.getConnection(url, user_name, password_DB);
            System.out.println("Connect Success");
        }catch(SQLException e) {
            System.err.println("con Error:" + e.getMessage());
            e.printStackTrace();
        }
        con.close();


%>
<html>
<head>
    <title>delete-form</title>
    <h1>비밀번호 확인</h1>

</head>
<script type="text/javascript">
    function DeleteChk() {
        var password = document.getElementById('password');

        if (password.value == "") {
            alert("비밀번호를 입력하세요");
            password.focus();
            return false;
        }
    }
</script>
<body>
<form name="board_delete_form" action="board_delete_ok.jsp" method="post" onsubmit="return DeleteChk()">
<table>
    <tbody>
        <tr>
            <th>비밀번호</th>
            <td>
                <input type="password" id="password" name="password" size="20" maxlength="50" value="">
            </td>
        </tr>
    </tbody>
</table>
<input type="hidden" name="num" value="<%=num%>">
<input type="submit" value="삭제">
<input type="button" value="취소" onclick="window.location='board_view.jsp?num=<%=num%>'">
</form>
</body>
</html>
