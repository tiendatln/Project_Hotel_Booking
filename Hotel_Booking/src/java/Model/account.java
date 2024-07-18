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

    /**
     *
     */
    public account() {
    }

    /**
     *
     * @param username
     */
    public account(String username) {
        this.username = username;
    }

    public account(String username, String name) {
        this.name = name;
    }

    /**
     *
     * @param username
     * @param password
     * @param is_owner
     * @param is_manager
     * @param is_adnmin
     * @param ban_status
     * @param report_count
     * @param email
     * @param name
     * @param age
     * @param phone
     * @param id_number
     */
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

    /**
     *
     * @return
     */
    public String getUsername() {
        return username;
    }

    /**
     *
     * @param username
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     *
     * @return
     */
    public String getPassword() {
        return password;
    }

    /**
     *
     * @param password
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     *
     * @return
     */
    public String getName() {
        return name;
    }

    /**
     *
     * @param name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     *
     * @return
     */
    public int getAge() {
        return age;
    }

    /**
     *
     * @param age
     */
    public void setAge(int age) {
        this.age = age;
    }

    /**
     *
     * @return
     */
    public String getEmail() {
        return email;
    }

    /**
     *
     * @param email
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     *
     * @return
     */
    public String getPhone() {
        return phone;
    }

    /**
     *
     * @param phone
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     *
     * @return
     */
    public String getId_number() {
        return id_number;
    }

    /**
     *
     * @param id_number
     */
    public void setId_number(String id_number) {
        this.id_number = id_number;
    }

    /**
     *
     * @return
     */
    public byte getIs_owner() {
        return is_owner;
    }

    /**
     *
     * @param is_owner
     */
    public void setIs_owner(byte is_owner) {
        this.is_owner = is_owner;
    }

    /**
     *
     * @return
     */
    public byte getIs_manager() {
        return is_manager;
    }

    /**
     *
     * @param is_manager
     */
    public void setIs_manager(byte is_manager) {
        this.is_manager = is_manager;
    }

    /**
     *
     * @return
     */
    public byte getIs_adnmin() {
        return is_adnmin;
    }

    /**
     *
     * @param is_adnmin
     */
    public void setIs_adnmin(byte is_adnmin) {
        this.is_adnmin = is_adnmin;
    }

    /**
     *
     * @return
     */
    public byte getBan_status() {
        return ban_status;
    }

    /**
     *
     * @param ban_status
     */
    public void setBan_status(byte ban_status) {
        this.ban_status = ban_status;
    }

    /**
     *
     * @return
     */
    public int getReport_count() {
        return report_count;
    }

    /**
     *
     * @param report_count
     */
    public void setReport_count(int report_count) {
        this.report_count = report_count;
    }

}
