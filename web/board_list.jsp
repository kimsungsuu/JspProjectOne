<%--
  Created by IntelliJ IDEA.
  User: LG677
  Date: 2022-07-05
  Time: ���� 3:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="EUC-KR" %>
<%
    String boardTitle = "board_list";
%>
<%@ page import="java.sql.*" %>
<%--<%@ page import="board_bean" %>--%>
<%@ page import="java.util.Vector"%>

<%
    Connection con = null;

    String url = "jdbc:mysql://localhost:3306/user?useSSL=false";
    String user_name = "root"; //  MySQL ���� ���̵�
    String password = "pw1234"; // MySQL ���� ��й�ȣ

//   1.����̹� �ε�
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("connect success!!!!");
    } catch (ClassNotFoundException e) {
        System.err.println(" !! <JDBC Driver Error> Driver load Error ��������: " + e.getMessage());
        e.printStackTrace();
    }

    // 2.����
    try {
        con = DriverManager.getConnection(url, user_name, password);
        System.out.println("Connect Success");
    } catch(SQLException e) {
        System.err.println("con Error:" + e.getMessage());
        e.printStackTrace();
    }
    int total = 0;

    Statement stmt = con.createStatement();

    String sqlCount = "SELECT * FROM member";
    ResultSet rs = stmt.executeQuery(sqlCount);

    if(rs.next()){
        total = rs.getInt(1);
    }
    rs.close();

    String sqlList = "SELECT num,category,title,writer,create_date,views,mod_date FROM member ORDER BY num DESC";
    rs = stmt.executeQuery(sqlList);


%>

<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
    <title><%= boardTitle%>></title>

<%--    �ش��ϴ� url�� �̵��� �� �ֵ��� �ڹٽ�ũ��Ʈ �Լ� ����--%>
    <script type="text/javascript">
        function gourl(url){
            location.href=url;
        }
    </script>

    <h1>�Խ���-���</h1>
    <div id="search">
        <label>�����<input type="date" | type = "month" | type="week" ></label>
        <input type="date" | type = "month" | type="week" >
        <input type="text" placeholder="��ü ī�װ�" list="pack">
        <datalist id="pack">
            <option value="Java">Java</option>
            <option value="Javascript">Javascript</option>
            <option value="Database">Database</option>
        </datalist>

        <input type="text" placeholder="�˻�� �Է����ּ���(���� + �ۼ��� + ����)">
        <input type="submit"  value="�˻�">
    </div>
</head>
<body>
<form name="searchform" action="" method="get"></form>
<nav id="board_list">
    <table>
        <thead>
        <tr>
            <th>ī�װ�</th>
            <th>����</th>
            <th>�ۼ���</th>
            <th>��ȸ��</th>
            <th>��� �Ͻ�</th>
            <th>���� �Ͻ�</th>
        </tr>
        </thead>
        <tbody >
<%--        �Խù��� ���ٸ�--%>
        <%
        if(total==0){
        %>
        <tr>
            <td>��ϵ� �Խù��� �����ϴ�.</td>
        </tr>
<%--        �Խù��� �����Ѵٸ� ���--%>
        <%
            }else{
            while(rs.next()){
                int num = rs.getInt("num");
                String category = rs.getString("category");
                String title = rs.getString("title");
                String writer = rs.getString("writer");
                int views = rs.getInt("views");
                Date mod_date = rs.getDate("mod_date");
                Date create_date =rs.getDate("create_date");
        %>
        <tr>
            <td style="width:100px"><%=category%></td>
<%--            title�� Ŭ���ϸ� �Խù��� �� �� �ֵ��� ����--%>
            <td ><a href="board_view.jsp?num=<%=num%>>"><%=title%></a></td>
            <td ><%=writer%></td>
            <td ><%=views%></td>
            <td ><%=create_date%></td>
            <td ><%=mod_date%></td>
        </tr>
        <%
            }
        }
            // 3.����
            try {
                if(con != null)
                    con.close();
                stmt.close();
                rs.close();
            } catch (SQLException e) {}
        %>
        </tbody>
        <tfoot>
            <tr>
                <td align="center" colspan="5"></td>
            </tr>
        </tfoot>
    </table>
</nav>
</body>
<footer>
    <p>
        <input type="submit" value = "�۾���" onclick="gourl('board_write.jsp')">
    </p>
</footer>
</html>