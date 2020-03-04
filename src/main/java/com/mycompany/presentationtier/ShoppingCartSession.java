/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.Item;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admins
 */
public class ShoppingCartSession {
    private String uuid;
    private List<Item> itemList = new ArrayList<>();

    public ShoppingCartSession(String uuid) {
        this.uuid = uuid;
    }

    public List<Item> getItemList() {
        return itemList;
    }

    public void setItemList(List<Item> itemList) {
        this.itemList = itemList;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
    
    
}
