/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import com.mycompany.bussinesstier.BussinessService;
import com.mycompany.bussinesstier.BussinessService_Service;

/**
 *
 * @author Admins
 */
public class BussinessServiceProxy {
    //get a single bussiness service port
    private static BussinessService_Service instance = new BussinessService_Service();

    private BussinessServiceProxy() {}

    public static BussinessService getProxy() {
        BussinessService proxy = instance.getBussinessServicePort();
        return proxy;
    }
}
