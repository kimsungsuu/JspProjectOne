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

    String sqlCount = "SELECT COUNT(*) FROM member";
    ResultSet rs = stmt.executeQuery(sqlCount);

    if(rs.next()){
        total = rs.getInt(1);
    }

    //    String sqlList = "SELECT num,category,title,writer,date,text,available,views,mode_date FROM member ORDER BY num DESC";
//    rs = stmt.executeQuery(sqlList);


%>

<%
//    request.setCharacterEncoding("EUC-KR");
    //request �޼ҵ尡 import �Ǿ� ���� �ʾƼ� ������ �߻��ϴ°����� �����Ѵ�.
    //beans �ڹ� ���� �Ǵ� Mgr �ڹ� ���� �ȿ� import �Ǿ����� ������ �����Ѵ�.

    int totalRecord = 0;    //��ü ���ڵ� ��
    int numPerPage = 10;    // ������ �� ���ڵ� ��
    int pagePerBlock = 10;  //���� ������ ��

    int totalPage=0;    //��ü ������ ��
    int totalBlock=0;   //��ü �� ��

    int nowPage=1;  // ���� ������
    int nowBlock=1; // ���� ��

    //�� �������� ��µǴ� �Խù� ��.
    int start=0;
    int end=10;

    //���� �о�� �Խù� ��
    int listSize=0;

    //�˻��� ���� ������(���� + �ۼ��� + ����)
//    String title="", writer ="", text ="";


%>

<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
    <title><%= boardTitle%>></title>
    <script type="text/javascript">
        function gourl(url){
            location.href=url;
        }
    </script>
    <h1>�Խ���-���</h1>
<%--    CSS--%>
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
        <colgroup>
            <col style="width: auto" />
            <col style="width: auto" />
            <col style="width: auto" />
            <col style="width: auto" />
            <col style="width: auto" />
            <col style="width: auto" />
        </colgroup>
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
        <%
        if(total==0){
        %>
        <tr>
            <td>��ϵ� �Խù��� �����ϴ�.</td>
        </tr>
        <%
            }else{
            while(rs.next()){
                int num = rs.getInt(1);
                String category = rs.getString(2);
                String title = rs.getString(3);
                String writer = rs.getString(4);
                int views = rs.getInt(6);
                Date mod_date = rs.getDate(7);
                Date create_date =rs.getDate(9);
        %>
        <tr>
            <td style="width:100px"><%=num%></td>
            <td style="width:100px"><%=category%></td>
            <td ><a href="board_view.jsp?num=<%=num%>>"><%=title%></a></td>
            <td ><%=writer%></td>
            <td ><%=views%></td>
            <td ><%=create_date%></td>
            <td ><%=mod_date%></td>

            <td style="width:100px">Java</td>
            <td ><a href="board_view.jsp?num=<%=num%>>">Okky �����ٶ󸶹ٻ� �ݰ����ϴ�</a></td>
            <td >�輺��</td>
            <td >12</td>
            <td >2022.7.6</td>
            <td >2022.7.6</td>
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