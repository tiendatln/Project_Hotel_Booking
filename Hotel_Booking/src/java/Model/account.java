/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class account {

    private String username;
    private String password;
    private byte is_owner;
    private byte is_manager;
    private byte is_adnmin;
    private byte ban_status;
    private int report_count;
    private String email;
    private String name;
    private int age;
    private String phone;
    private String id_number;

    public account() {
    }

    public account(String username) {
        this.username = username;
    }

    public account(String username, String password, byte is_owner, byte is_manager, byte is_adnmin, byte ban_status, int report_count, String email, String name, int age, String phone, String id_number) {
        this.username = username;
        this.password = password;
        this.is_owner = is_owner;
        this.is_manager = is_manager;
        this.is_adnmin = is_adnmin;
        this.ban_status = ban_status;
        this.report_count = report_count;
        this.email = email;
        this.name = name;
        this.age = age;
        this.phone = phone;
        this.id_number = id_number;
    }

    

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getId_number() {
        return id_number;
    }

    public void setId_number(String id_number) {
        this.id_number = id_number;
    }

    public byte getIs_owner() {
        return is_owner;
    }

    public void setIs_owner(byte is_owner) {
        this.is_owner = is_owner;
    }

    public byte getIs_manager() {
        return is_manager;
    }

    public void setIs_manager(byte is_manager) {
        this.is_manager = is_manager;
    }

    public byte getIs_adnmin() {
        return is_adnmin;
    }

    public void setIs_adnmin(byte is_adnmin) {
        this.is_adnmin = is_adnmin;
    }

    public byte getBan_status() {
        return ban_status;
    }

    public void setBan_status(byte ban_status) {
        this.ban_status = ban_status;
    }

    public int getReport_count() {
        return report_count;
    }

    public void setReport_count(int report_count) {
        this.report_count = report_count;
    }

}
