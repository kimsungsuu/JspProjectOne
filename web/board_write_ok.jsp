<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-06
  Time: ���� 9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="EUC-KR" %>
<%@ page import ="java.sql.*"%>
<%
    //�ѱ��� ?�� ��
    request.setCharacterEncoding("UTF-8");
%>
<%--�۾��� �� �� ������� DB�� ����ǵ��� �ϴ� jsp ����--%>

<%--DBó��--%>
<%
    Connection con = null;

    String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
    String user_name = "root"; //  MySQL ���� ���̵�
    String password_DB = "pw1234"; // MySQL ���� ��й�ȣ

//   1.����̹� �ε�
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


    // 2.����
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
    self.window.alert("�Է��� ���� �����Ͽ����ϴ�.");
    location.href="board_list.jsp";
</script>
<body>

</body>
</html>
