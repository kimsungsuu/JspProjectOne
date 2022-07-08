<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-08
  Time: 오전 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import ="java.sql.*"%>

<%
        Connection con = null;

        String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
        String user_name = "root"; //  MySQL 서버 아이디
        String password_DB = "pw1234"; // MySQL 서버 비밀번호

        String writer = request.getParameter("writer");
        String password = "";
        String title = request.getParameter("title");
        String text = request.getParameter("text");
        String category = request.getParameter("category");
        int num = Integer.parseInt(request.getParameter("num"));
//        String num = request.getParameter("num");


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

            Statement stmt = con.createStatement();
            String sql = "SELECT category,title,writer,text,create_date, mod_date FROM board WHERE num="+num;


            ResultSet rs = stmt.executeQuery(sql);

            if(rs.next()) {
                 category = rs.getString("category");
                 title = rs.getString("title");
                 writer = rs.getString("writer");
                 text = rs.getString("text");
                Date create_date = rs.getDate("create_date");
                Date mod_date = rs.getDate("mod_date");

        %>

<html>
<head>
    <title>board_modify</title>
    <script type="text/javascript">
        function BoardModifyChk(){
            var writer = document.getElementById('writer');
            var password = document.getElementById('password');
            var title = document.getElementById('title');

            if(title.value== ""){
                alert("제목을 입력하세요.");
                title.focus();
                return false;
            }

            if(writer.value== ""){
                alert("작성자명을 입력하세요.");
                writer.focus();
                return false;
            }

            if(password.value== ""){
                alert("비밀번호를 입력하세요.");
                password.focus();
                return false;
            }
        }
    </script>
</head>
<body>
<form name="board_modify_form" action="board_modify_ok.jsp" method="post" onsubmit="return BoardModifyChk();">
    <table>
        <tbody>
        <tr>
            <th>카테고리</th>
            <td><%=category%></td>
        </tr>
        <tr>
            <th>등록 일시</th>
            <td><%=create_date%></td>
        </tr>
        <tr>
            <th>수정 일시</th>
            <td><%=mod_date%></td>
        </tr>
        <tr>
            <th>조회수</th>
            <td></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>
                <input type="text" id="writer" name="writer" maxlength="50" value="<%=writer%>">
            </td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="text" placeholder="비밀번호" id="password" name="password" maxlength="50" value="<%=password%>">
        </tr>
        <tr>
            <th>제목</th>
            <td><input type="text" id="title" name="title" maxlength="50" value="<%=title%>"></td>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="2">
                <textarea name="text" id="text" cols="75" rows="15" ><%=text%></textarea>
            </td>
        </tr>
        <tr>
            <th>파일 첨부</th>
            <td> </td>
        </tr>
        </tbody>
    </table>
        <input type="hidden" name="num" value="<%=num%>">
        <input type="submit" value="수정">
        <input type="button" value="취소" onclick="history.back()">
</form>
<%
        }

        rs.close();
        con.close();
        stmt.close();
    } catch(SQLException e) {
        System.err.println("con Error:" + e.getMessage());
        e.printStackTrace();
    }
%>
</body>
</html>
