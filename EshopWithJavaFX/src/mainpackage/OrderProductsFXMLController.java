/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/javafx/FXMLController.java to edit this template
 */
package mainpackage.Controllers;

import java.awt.event.ActionEvent;
import java.io.File;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.ResourceBundle;
import java.util.UUID;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import mainpackage.JDBCPosrgreSQLConnector;
import mainpackage.Models.OrderProducts;
import mainpackage.Models.Products;

/**
 * FXML Controller class
 *
 * @author Mike
 */
public class OrderProductsFXMLController implements Initializable {

    
    @FXML
    private Button b_user_address;    
    @FXML
    private Button b_Dsc;

    @FXML
    private Button b_Pr;

    @FXML
    private Button b_add;

    @FXML
    private Button b_home;

    @FXML
    private Button b_orders;

    @FXML
    private Button b_orders_products;

    @FXML
    private Button b_remove;

    @FXML
    private Button b_s1;

    @FXML
    private Button b_update;

    @FXML
    private TableColumn<OrderProducts, Integer> col_id;

    @FXML
    private TableColumn<OrderProducts, UUID> col_order_number;

    @FXML
    private TableColumn<OrderProducts, Float> col_order_value;

    @FXML
    private TableColumn<OrderProducts, Integer> col_prod_id;

    @FXML
    private TableColumn<OrderProducts, Integer> col_quantity;

    @FXML
    private TableView<OrderProducts> table_order_products;

    @FXML
    private TextField tf_order_id;

    @FXML
    private TextField tf_order_value;

    @FXML
    private TextField tf_id;

    @FXML
    private TextField tf_product_id;

    @FXML
    private TextField tf_quantity;
    
    ObservableList<OrderProducts> listM;

    int index = -1;
    
    Connection con = null;
    ResultSet set = null;
    PreparedStatement ps=null;
    
    
        public void showOrderProducts(){
        listM = JDBCPosrgreSQLConnector.getDataOrderProducts();
        //to PropertyValueFactory pairnei to argument apo ton Constructor ths klashs Products
        col_id.setCellValueFactory(new PropertyValueFactory<OrderProducts,Integer>("ID"));
        tf_order_id.setCellValueFactory(new PropertyValueFactory<OrderProducts,UUID>("Order ID"));
        tf_product_id.setCellValueFactory(new PropertyValueFactory<OrderProducts,Integer>("Product ID"));
        tf_quantity.setCellValueFactory(new PropertyValueFactory<OrderProducts,Integer>("Quantity"));
        tf_order_value.setCellValueFactory(new PropertyValueFactory<OrderProducts,Float>("Order Value"));
        table_order_products.setItems(listM);
    }

    public void executeQuery(String query){
        con = JDBCPosrgreSQLConnector.ConnectDb(); 
        try{
            PreparedStatement ps = con.prepareStatement(query);
            ps.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }
    }        
    @FXML
    void handleCreateButton(ActionEvent event) {
        String query = "INSERT INTO orderproducts(orderno,productid,quantity,ordervalue) VALUES ('" 
                + tf_order_id.getText()
                +"','"+tf_product_id.getText()
                +"','"+tf_quantity.getText()
                +"','"+tf_order_value.getText()+")";
        executeQuery(query);
        showOrderProducts();        

    }

    @FXML
    void handleDeleteButton(ActionEvent event) {
        String query = "DELETE FROM orderproducts WHERE id =" +tf_id.getText()+"";

        executeQuery(query);
        showOrderProducts();
    }
    

    @FXML
    void handleUpdateButton(ActionEvent event) {
        String query = "UPDATE orderproducts SET orderno = "+tf_order_id.getText()
                +"', productid = '"+tf_product_id.getText()
                +"', quantity = '"+tf_quantity.getText()
                +"', ordervalue = '"+tf_order_value.getText()+"";

        executeQuery(query);
        showOrderProducts();        
    }
    
     public void handleButtonHome() throws Exception{
        URL url = new File("src/mainpackage/Fxml/menuFXML.fxml").toURI().toURL();
        Parent root = FXMLLoader.load(url);
        
        Stage window = (Stage) b_home.getScene().getWindow();
        window.setScene(new Scene(root,930,680));
    }
     
    public void handleButtonScene1() throws Exception{
        URL url = new File("src/mainpackage/Fxml/scene1FXML.fxml").toURI().toURL();
        Parent root = FXMLLoader.load(url);
        
        Stage window = (Stage) b_s1.getScene().getWindow();
        window.setScene(new Scene(root,930,680));
    }
    
     public void handleButtonProducts() throws Exception{
        URL url = new File("src/mainpackage/Fxml/productsFXML.fxml").toURI().toURL();
        Parent root = FXMLLoader.load(url);
        
        Stage window = (Stage) b_Pr.getScene().getWindow();
        window.setScene(new Scene(root,930,680));
    }
     
    @FXML
    void handleButtonDiscounts() throws Exception{
        URL url = new File("src/mainpackage/Fxml/discountsFXML.fxml").toURI().toURL();
        Parent root = FXMLLoader.load(url);
        
        Stage window = (Stage) b_Dsc.getScene().getWindow();
        window.setScene(new Scene(root,930,680));
    }
    
        @FXML
    void handleButtonOrders(ActionEvent event)throws Exception {
        URL url = new File("src/mainpackage/Fxml/ordersFXML.fxml").toURI().toURL();
        Parent root = FXMLLoader.load(url);
        
        Stage window = (Stage) b_orders.getScene().getWindow();
        window.setScene(new Scene(root,930,680));
    }
    
     @FXML
    void handleButtonOrders_prod(ActionEvent event)throws Exception {
        URL url = new File("src/mainpackage/Fxml/ordersFXML.fxml").toURI().toURL();
        Parent root = FXMLLoader.load(url);
        
        Stage window = (Stage) b_orders_products.getScene().getWindow();
        window.setScene(new Scene(root,930,680));
    }
        @FXML
    void handleButtonUserAddress(ActionEvent event)throws Exception {
        URL url = new File("src/mainpackage/Fxml/userAddressFXML.fxml").toURI().toURL();
        Parent root = FXMLLoader.load(url);
        
        Stage window = (Stage) b_user_address.getScene().getWindow();
        window.setScene(new Scene(root,930,680));
    }

    
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    
    
}

