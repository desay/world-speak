package com.world.speak.domain.response;

import com.world.speak.domain.User;

public class AdditionalResponseItem {
    private Long identifiableid;
    private User test;

    public Long getIdentifiableid() {
        return identifiableid;
    }

    public void setIdentifiableid(Long identifiableid) {
        this.identifiableid = identifiableid;
    }

    public User getTest() {
        return test;
    }

    public void setTest(User user) {
        this.test = test;
    }
}
