/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author tiend
 */
public class reservation {

    private int id;
    private int status;
    private Date re_date;
    private int quantity;
    private Date check_in_date;
    private Date check_out_date;
    private int list_price;
    private room room;
    private service service;
    private account account;

    /**
     *
     */
    public reservation() {
    }

    public reservation(int quantity, room room) {
        this.quantity = quantity;
        this.room = room;
    }

    /**
     *
     * @param room
     * @param account
     */
    public reservation(room room,  account account) {
        this.room = room;
        this.account = account;
    }

    public reservation(int id, int status, Date re_date, int quantity, Date check_in_date, Date check_out_date, int list_price, room room, service service, account account) {
        this.id = id;
        this.status = status;
        this.re_date = re_date;
        this.quantity = quantity;
        this.check_in_date = check_in_date;
        this.check_out_date = check_out_date;
        this.list_price = list_price;
        this.room = room;
        this.service = service;
        this.account = account;
    }

 

    public reservation(int id, int status, Date re_date, int quantity, Date check_in_date, Date check_out_date, int list_price) {
        this.id = id;
        this.status = status;
        this.re_date = re_date;
        this.quantity = quantity;
        this.check_in_date = check_in_date;
        this.check_out_date = check_out_date;
        this.list_price = list_price;
    }

    public room getRoom() {
        return room;
    }

    public void setRoom(room room) {
        this.room = room;
    }

    public service getService() {
        return service;
    }

    public void setService(service service) {
        this.service = service;
    }

    public account getAccount() {
        return account;
    }

    public void setAccount(account account) {
        this.account = account;
    }


    /**
     *
     * @return
     */
    public account getUsername() {
        return account;
    }

    /**
     *
     * @param account
     * @param username
     */
    public void setUsername(account account) {
        this.account = account;
    }

    /**
     *
     * @return
     */
    public int getId() {
        return id;
    }

    /**
     *
     * @param id
     */
    public void setId(int id) {
        this.id = id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    /**
     *
     * @return
     */
    public Date getRe_date() {
        return re_date;
    }

    /**
     *
     * @param re_date
     */
    public void setRe_date(Date re_date) {
        this.re_date = re_date;
    }

    /**
     *
     * @return
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     *
     * @param quantity
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     *
     * @return
     */
    public Date getCheck_in_date() {
        return check_in_date;
    }

    /**
     *
     * @param check_in_date
     */
    public void setCheck_in_date(Date check_in_date) {
        this.check_in_date = check_in_date;
    }

    /**
     *
     * @return
     */
    public Date getCheck_out_date() {
        return check_out_date;
    }

    /**
     *
     * @param check_out_date
     */
    public void setCheck_out_date(Date check_out_date) {
        this.check_out_date = check_out_date;
    }

    public int getList_price() {
        return list_price;
    }

    public void setList_price(int list_price) {
        this.list_price = list_price;
    }


}
