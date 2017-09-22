package com.world.speak.domain.response;

public class AjaxResponseBody {

    private ValueResponse values;
    private AdditionalResponseItem additionalinfo;
    private Boolean addedrow;

    public ValueResponse getValues() {
        return values;
    }

    public void setValues(ValueResponse values) {
        this.values = values;
    }

    public AdditionalResponseItem getAdditionalinfo() {
        return additionalinfo;
    }

    public void setAdditionalinfo(AdditionalResponseItem additionalinfo) {
        this.additionalinfo = additionalinfo;
    }

    public Boolean getAddedrow() {
        return addedrow;
    }

    public void setAddedrow(Boolean addedrow) {
        this.addedrow = addedrow;
    }
}
