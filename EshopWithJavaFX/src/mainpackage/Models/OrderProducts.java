/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mainpackage.Models;

import java.util.UUID;

/**
 *
<<<<<<< HEAD
 * @author kalou
 */
public class OrderProducts {
    private int id,productid,quantity ;
    private int orderno;
    private float ordervalue;

    public OrderProducts(int id,int orderno, int productid, int quantity, float ordervalue) {
        this.id = id;
        this.productid = productid;
        this.quantity = quantity;
        this.orderno = orderno;
        this.ordervalue = ordervalue;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setOrderno(int orderno) {
        this.orderno = orderno;
    }

    public void setOrdervalue(float ordervalue) {
        this.ordervalue = ordervalue;
    }
    public int getId() {
        return id;
    }

    public int getProductid() {
        return productid;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getOrderno() {
        return orderno;
    }

    public float getOrdervalue() {
        return ordervalue;
    }
}
