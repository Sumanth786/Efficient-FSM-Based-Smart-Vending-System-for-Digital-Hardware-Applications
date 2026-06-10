module vending_machine(
    input clk,
    input rst,

    input coin5,
    input coin10,

    input sel_a,
    input sel_b,

    input cancel,

    input stock_a,
    input stock_b,

    output reg product_a,
    output reg product_b,

    output reg change5,

    output reg refund5,
    output reg refund10,

    output reg out_of_stock,

    output reg [7:0] sale_count
);

parameter S0  = 3'd0;
parameter S5  = 3'd1;
parameter S10 = 3'd2;
parameter S15 = 3'd3;
parameter S20 = 3'd4;

reg [2:0] state,next_state;
reg [1:0] product_sel;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= S0;
        product_sel <= 0;
        sale_count <= 0;
        out_of_stock <= 0;
    end
    else
    begin
        state <= next_state;

        // Product Selection + Stock Check
        if(sel_a)
        begin
            if(stock_a)
            begin
                product_sel <= 1;
                out_of_stock <= 0;
            end
            else
            begin
                product_sel <= 0;
                out_of_stock <= 1;

                $display("%0t ns : Product A Out Of Stock", $time);
            end
        end

        else if(sel_b)
        begin
            if(stock_b)
            begin
                product_sel <= 2;
                out_of_stock <= 0;
            end
            else
            begin
                product_sel <= 0;
                out_of_stock <= 1;

                $display("%0t ns : Product B Out Of Stock", $time);
            end
        end
    end
end

//--------------------------------------------------
// Next State Logic
//--------------------------------------------------

always @(*)
begin

    next_state = state;

    if(cancel)
        next_state = S0;

    else if(product_sel == 0)
        next_state = S0;

    else
    begin

        case(state)

        S0:
        begin
            if(coin5)
                next_state = S5;

            else if(coin10)
                next_state = S10;
        end

        S5:
        begin
            if(coin5)
                next_state = S10;

            else if(coin10)
                next_state = S15;
        end

        S10:
        begin
            if(coin5)
                next_state = S15;

            else if(coin10)
                next_state = S20;
        end

        S15:
        begin
            if(product_sel == 1)
                next_state = S0;

            else if(product_sel == 2 && coin5)
                next_state = S20;
        end

        S20:
            next_state = S0;

        default:
            next_state = S0;

        endcase

    end

end

//--------------------------------------------------
// Output Logic
//--------------------------------------------------

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        product_a <= 0;
        product_b <= 0;
        change5 <= 0;

        refund5 <= 0;
        refund10 <= 0;
    end

    else
    begin

        product_a <= 0;
        product_b <= 0;
        change5 <= 0;

        refund5 <= 0;
        refund10 <= 0;

        //------------------------------------
        // Cancel Logic
        //------------------------------------

        if(cancel)
        begin

            $display("%0t ns : Transaction Cancelled", $time);

            case(state)

            S5 :
            begin
                refund5 <= 1;
                $display("%0t ns : Refund Rs.5", $time);
            end

            S10 :
            begin
                refund10 <= 1;
                $display("%0t ns : Refund Rs.10", $time);
            end

            S15 :
            begin
                refund10 <= 1;
                refund5  <= 1;
                $display("%0t ns : Refund Rs.15", $time);
            end

            endcase

        end

        //------------------------------------
        // Product A = ₹15
        //------------------------------------

        if(state == S15 && product_sel == 1)
        begin
            product_a <= 1;
            sale_count <= sale_count + 1;

            $display("%0t ns : Product A Dispensed", $time);
        end

        //------------------------------------
        // Product B = ₹20
        //------------------------------------

        if(state == S20 && product_sel == 2)
        begin
            product_b <= 1;
            sale_count <= sale_count + 1;

            $display("%0t ns : Product B Dispensed", $time);
        end

        //------------------------------------
        // Product A + Change
        //------------------------------------

        if(state == S20 && product_sel == 1)
        begin
            product_a <= 1;
            change5 <= 1;
            sale_count <= sale_count + 1;

            $display("%0t ns : Product A Dispensed + Change Rs.5 Returned", $time);
        end

    end

end

endmodule
