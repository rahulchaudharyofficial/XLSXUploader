({
    render : function(cmp, helper) {
            var ret = this.superRender();
            // do custom rendering here
            console.log("Custom render ready");
            return ret;
        }
})