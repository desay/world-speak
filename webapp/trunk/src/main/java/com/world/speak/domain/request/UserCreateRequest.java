package com.world.speak.domain.request;

public class UserCreateRequest {

    private ValueRequest values;
    private String additionalInfo;

    public ValueRequest getValues() {
        return values;
    }

    public void setValues(ValueRequest values) {
        this.values = values;
    }

    public String getAdditionalInfo() {
        return additionalInfo;
    }

    public void setAdditionalInfo(String additionalInfo) {
        this.additionalInfo = additionalInfo;
    }
}
