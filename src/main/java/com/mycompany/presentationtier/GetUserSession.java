/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admins
 */
public class GetUserSession {

    /**
     *
     * @param request
     * @param session
     * @return
     */
    public static UserSession getSession(HttpServletRequest request, HttpSession session) {
        UserSession userSession = null;
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("user-session-id")) {
                String sesID = cookie.getValue();
                Object sesObj = session.getAttribute(sesID);
                if (sesObj != null) {
                    userSession = (UserSession) sesObj;
                    break;
                }
            }
        }
        return userSession;
    }
    
    public static ShoppingCartSession getCartSession(HttpServletRequest request, HttpSession session) {
        ShoppingCartSession shoppingCartSession = null;
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("cart-session-id")) {
                String sesID = cookie.getValue();
                Object sesObj = session.getAttribute(sesID);
                if (sesObj != null) {
                    shoppingCartSession = (ShoppingCartSession) sesObj;
                    break;
                }
            }
        }
        return shoppingCartSession;
    }

}
