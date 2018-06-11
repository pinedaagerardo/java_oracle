/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import java.io.Serializable;
import java.sql.ResultSet;

/**
 *
 * @author Gerardo
 */
public class BeanConnection implements Serializable {
    
    private Conn conn;

    public BeanConnection(){
        super();
        conn = new Conn();
    }
    
    public boolean insertNew(String name){
        if(name==null || name.equals("")) return false;
        if(conn.abrir()){
            conn.execute("BEGIN test_pkg.insert_testtable('"+name+"'); END;");
            conn.cerrar();
            return true;
        }else
            return false;
    }
    
    public boolean deleteRecord(String id){
        if(id==null || id.equals("")) return false;
        if(conn.abrir()){
            conn.execute("BEGIN test_pkg.delete_testtable("+id+"); END;");
            conn.cerrar();
            return true;
        }else
            return false;
    }
    
    public boolean updateRecord(String id, String name){
        if(id==null || id.equals("")) return false;
        if(conn.abrir()){
            conn.execute("BEGIN test_pkg.update_testtable("+id+",'"+name+"' ); END;");
            conn.cerrar();
            return true;
        }else
            return false;
    }
    
    public ResultSet getAll(){
        ResultSet rs=null;
        if(conn.abrir()){
            rs=conn.executeQ("SELECT * FROM testtable");//conn.getAll();
            //conn.cerrar();
        }
        return rs;
    }
}
