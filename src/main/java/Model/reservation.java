/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class reservation {
    private int id;
    private byte status;
    private Date re_date;
    private int quantity;
    private Date check_in_date;
    private Date check_out_date;
    private long list_price;

    public reservation() {
    }

    public reservation(int id, byte status, Date re_date, int quantity, Date check_in_date, Date check_out_date, long list_price) {
        this.id = id;
        this.status = status;
        this.re_date = re_date;
        this.quantity = quantity;
        this.check_in_date = check_in_date;
        this.check_out_date = check_out_date;
        this.list_price = list_price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public Date getRe_date() {
        return re_date;
    }

    public void setRe_date(Date re_date) {
        this.re_date = re_date;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getCheck_in_date() {
        return check_in_date;
    }

    public void setCheck_in_date(Date check_in_date) {
        this.check_in_date = check_in_date;
    }

    public Date getCheck_out_date() {
        return check_out_date;
    }

    public void setCheck_out_date(Date check_out_date) {
        this.check_out_date = check_out_date;
    }

    public long getList_price() {
        return list_price;
    }

    public void setList_price(long list_price) {
        this.list_price = list_price;
    }
    
}
