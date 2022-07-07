<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-06
  Time: 오후 9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="EUC-KR" %>
<%@ page import ="java.sql.*"%>
<%
    //한글이 ?질 때
    request.setCharacterEncoding("UTF-8");
%>
<%--글쓰기 한 후 결과물이 DB에 저장되도록 하는 jsp 파일--%>

<%--DB처리--%>
<%
    Connection con = null;

    String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
    String user_name = "root"; //  MySQL 서버 아이디
    String password_DB = "pw1234"; // MySQL 서버 비밀번호

//   1.드라이버 로딩
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("connect success!!!!");
    } catch (ClassNotFoundException e) {
        System.err.println(" !! <JDBC Driver Error> Driver load Error : " + e.getMessage());
        e.printStackTrace();
    }

    String category = request.getParameter("category");
    String writer = request.getParameter("writer");
    String password = request.getParameter("password");
    String title = request.getParameter("title");
    String text = request.getParameter("text");


    // 2.연결
    try {
        con = DriverManager.getConnection(url, user_name, password_DB);
        System.out.println("Connect Success");

        String sql = "INSERT INTO board(category,writer,password,title,text,create_date,mod_date,views)"
                + "VALUES (?,?,?,?,?,now(),now(),0)";

        Statement stmt = con.createStatement();
        PreparedStatement pstmt = con.prepareStatement(sql);

        pstmt.setString(1, category);
        pstmt.setString(2, writer);
        pstmt.setString(3, password);
        pstmt.setString(4, title);
        pstmt.setString(5, text);

        pstmt.executeUpdate();

        pstmt.close();
        con.close();
        stmt.close();
    }
    catch(SQLException e) {
    System.err.println("con Error:" + e.getMessage());
    e.printStackTrace();
    }

%>


<html>
<head>
    <title>Title</title>

</head>
<script type="text/javascript">
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href="board_list.jsp";
</script>
<body>

</body>
</html>
