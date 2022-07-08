<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-08
  Time: 오전 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8"); //한글이 깨질 경우 %>

<%
    Connection con = null;

    String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
    String user_name = "root"; //  MySQL 서버 아이디
    String password_DB = "pw1234"; // MySQL 서버 비밀번호
    String password ="";

    String num = request.getParameter("num");
    if(num == null){
        response.sendRedirect("board_list.jsp");
    }


    String title = request.getParameter("title");
    String text = request.getParameter("text");
    String writer = request.getParameter("writer");
    String PASSWORD = request.getParameter("password");


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


        Statement stmt = con.createStatement();
        String sql = "SELECT password FROM board WHERE num="+ num;

        ResultSet rs = stmt.executeQuery(sql);

        if(rs.next()) {
            password = rs.getString("password");
        }

        if(password.equals(PASSWORD)){
            sql = "UPDATE board SET title ='"+title+"',text='"+text+"',writer='"+writer+"' WHERE num="+num;

            stmt.executeUpdate(sql);
%>
<script type = "text/javascript">
    self.window.alert("글이 수정되었습니다.");
    location.href="board_view.jsp?num=<%=num%>";
</script>
<%
    System.out.println("Connect Success");
}else{
%>
<script type="text/javascript">
    self.window.alert("비밀번호가 틀렸습니다.");
    history.back();
</script>
<%
            }
    } catch(SQLException e) {
        System.err.println("con Error:" + e.getMessage());
        e.printStackTrace();
    }

%>

<%--<html>--%>
<%--<head>--%>
<%--    <title>Title</title>--%>
<%--</head>--%>

<%--<body>--%>

<%--</body>--%>
<%--</html>--%>
