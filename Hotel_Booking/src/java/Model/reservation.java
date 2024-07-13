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
    private byte status;
    private Date re_date;
    private int quantity;
    private Date check_in_date;
    private Date check_out_date;
    private long list_price;
    private room room_id;
    private hotel hotel_id;
    private account username;

    /**
     *
     */
    public reservation() {
    }

    /**
     *
     * @param room_id
     * @param hotel_id
     * @param username
     */
    public reservation(room room_id, hotel hotel_id, account username) {
        this.room_id = room_id;
        this.hotel_id = hotel_id;
        this.username = username;
    }

    /**
     *
     * @param id
     * @param status
     * @param re_date
     * @param quantity
     * @param check_in_date
     * @param check_out_date
     * @param list_price
     * @param room_id
     * @param hotel_id
     * @param username
     */
    public reservation(int id, byte status, Date re_date, int quantity, Date check_in_date, Date check_out_date, long list_price, room room_id, hotel hotel_id, account username) {
        this.id = id;
        this.status = status;
        this.re_date = re_date;
        this.quantity = quantity;
        this.check_in_date = check_in_date;
        this.check_out_date = check_out_date;
        this.list_price = list_price;
        this.room_id = room_id;
        this.hotel_id = hotel_id;
        this.username = username;
    }

    /**
     *
     * @param id
     * @param status
     * @param re_date
     * @param quantity
     * @param check_in_date
     * @param check_out_date
     * @param list_price
     */
    public reservation(int id, byte status, Date re_date, int quantity, Date check_in_date, Date check_out_date, long list_price) {
        this.id = id;
        this.status = status;
        this.re_date = re_date;
        this.quantity = quantity;
        this.check_in_date = check_in_date;
        this.check_out_date = check_out_date;
        this.list_price = list_price;
    }

    /**
     *
     * @return
     */
    public room getRoom_id() {
        return room_id;
    }

    /**
     *
     * @param room_id
     */
    public void setRoom_id(room room_id) {
        this.room_id = room_id;
    }

    /**
     *
     * @return
     */
    public hotel getHotel_id() {
        return hotel_id;
    }

    /**
     *
     * @param hotel_id
     */
    public void setHotel_id(hotel hotel_id) {
        this.hotel_id = hotel_id;
    }

    /**
     *
     * @return
     */
    public account getUsername() {
        return username;
    }

    /**
     *
     * @param username
     */
    public void setUsername(account username) {
        this.username = username;
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

    /**
     *
     * @return
     */
    public byte getStatus() {
        return status;
    }

    /**
     *
     * @param status
     */
    public void setStatus(byte status) {
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

    /**
     *
     * @return
     */
    public long getList_price() {
        return list_price;
    }

    /**
     *
     * @param list_price
     */
    public void setList_price(long list_price) {
        this.list_price = list_price;
    }
    
}
