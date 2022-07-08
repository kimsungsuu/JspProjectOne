<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-06
  Time: 오후 9:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import ="java.sql.*"%>
<%
    Connection con = null;

    String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
    String user_name = "root"; //  MySQL 서버 아이디
    String password_DB = "pw1234"; // MySQL 서버 비밀번호
    int num=0;
    if(request.getParameter("num") != null){
        num = Integer.parseInt(request.getParameter("num"));
    }


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

    String sql = "SELECT category,title,writer,text,create_date, mod_date FROM board WHERE num=?";

    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1,num);

    ResultSet rs = pstmt.executeQuery();

    if(rs.next()){
        String category = rs.getString("category");
        String title = rs.getString("title");
        String writer = rs.getString("writer");
        String text = rs.getString("text");
        Date create_date = rs.getDate("create_date");
        Date mod_date = rs.getDate("mod_date");
%>
<html>
<head>
    <title>Title</title>
    <h1>게시판 - 보기</h1>
</head>
<script type="text/javascript">
        function gourl(url){
        location.href=url;
        }
</script>
<body>
<table>
    <tr>
        <th>카테고리</th>
        <td><%=category%></td>
    </tr>

    <tr>
        <th>제목</th>
        <td><%=title%></td>
    </tr>
    <tr>
        <th>작성자</th>
        <td><%=writer%></td>
    </tr>
    <tr>
        <th>내용</th>
        <td><%=text%></td>
    </tr>
    <tr>
        <th>작성일자</th>
        <td><%=create_date%></td>
        <th>수정일자</th>
        <td><%=mod_date%></td>
    </tr>

</table>
<%
    }
    rs.close();
    con.close();
    pstmt.close();
    } catch(SQLException e) {
        System.err.println("con Error:" + e.getMessage());
        e.printStackTrace();
    }
%>
</body>
<footer>
    <input type="button" value="목록" onclick="gourl('board_list.jsp')" >
    <input type="submit" value="수정" onclick="window.location='board_modify.jsp?num=<%=num%>'">
    <input type="submit" value="삭제">
</footer>
</html>
