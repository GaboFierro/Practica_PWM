module pwm (
    input wire clk,
    input wire enable,
    input wire btn_up,
    input wire btn_down,
    output reg PWM
);

    parameter PERIOD = 1_000_000;
    parameter PULSE_MIN = 25_000;
    parameter PULSE_MAX = 125_000;
    parameter STEP_PERCENT = 100;

    wire btn_up_stable;
    wire btn_down_stable;
    wire slow_clk;

    Debouncer debouncer_inst_up (
        .clk(clk),
        .rst(0),
        .pb_in(btn_up),
        .pb_out(btn_up_stable)
    );

    Debouncer debouncer_inst_down (
        .clk(clk),
        .rst(0),
        .pb_in(btn_down),
        .pb_out(btn_down_stable)
    );

    clk_divider clock_divider_inst (
        .clk(clk),
        .rst(0),
        .clk_div(slow_clk)
    );

    reg [10:0] duty_percent = 25;
    reg [19:0] pulse_width = PULSE_MIN;
    reg [19:0] counter = 0;

    reg btn_up_last = 1;
    reg btn_down_last = 1;

    always @(posedge slow_clk) begin
        if (enable) begin
            if (!btn_up_stable && btn_up_last) begin
                if (duty_percent < 125)
                    duty_percent <= duty_percent + STEP_PERCENT;
            end

            if (!btn_down_stable && btn_down_last) begin
                if (duty_percent > 25)
                    duty_percent <= duty_percent - STEP_PERCENT;
            end
        end
        btn_up_last <= btn_up_stable;
        btn_down_last <= btn_down_stable;
    end

    always @(posedge clk) begin
        if (!enable) begin
            PWM <= 0;
            counter <= 0;
        end else begin
            pulse_width <= PULSE_MIN + ((PULSE_MAX - PULSE_MIN) * (duty_percent - 25)) / 100;
            
            if (counter < pulse_width)
                PWM <= 1;
            else
                PWM <= 0;

            if (counter >= PERIOD - 1)
                counter <= 0;
            else
                counter <= counter + 1;
        end
    end

endmodule
