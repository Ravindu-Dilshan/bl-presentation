/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.User;

/**
 *
 * @author Admins
 */
public class UserSession {
    private String uuid;
    private String time;
    private User user;

    public UserSession() {
        uuid = "";
        time = "";
        user = null;
    }

    public UserSession(String uuid, String time, User user) {
        this.uuid = uuid;
        this.time = time;
        this.user = user;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
