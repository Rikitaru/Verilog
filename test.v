`timescale 1 ns/ 1 ps //количество тактов на 1 наносекунду
module mux(
            input  clk,
            input  enable,
            input  reset,
            input [3:0]addr, //вход адреса
            input [15:0]data, //входы данных
            output reg out //выход - значение по адресу, указанному на соответственном входе. РЕГИСТРОВЫЙ, может в изменяемость
        );
        always @(posedge clk)
		  begin          
				case(addr) //выборка адреса
                0: out <= ~data[0]; //запись в данные нужные биты по addr
                1: out <= ~data[1];
                2: out <= ~data[2];
                3: out <= ~data[3];
                4: out <= ~data[4];
                5: out <= ~data[5];
                6: out <= ~data[6];
                7: out <= ~data[7];
                8: out <= ~data[8];
                9: out <= ~data[9];
                10: out <= ~data[10];
                11: out <= ~data[11];
                12: out <= ~data[12];
                13: out <= ~data[13];
                14: out <= ~data[14];
                15: out <= ~data[15];
              default: out <= ~4'd0;
            endcase
        end
endmodule

`timescale 10 ps / 1 ps
module mux_vlg_tst();
		reg clk;
		reg enable;
		reg reset;
      wire out;
		reg[15:0] data;
		reg[3:0] addr;
		mux i1_1(
		.clk(clk),
		.data(data),
		.addr(addr),
		.out(out),
		.enable(enable),
		.reset(reset)
		);
		//Инициализация
		initial
		begin
				$display("Testbench launched");
				clk <= 0;
				enable <= 1;
				reset <= 1;
		end
		
		/*initial
		begin
				
				//forever #10 clk = ~clk;
		end*/
		//Задаем частоту
		integer i=0;
		initial
		begin//работа симуляции			
		clk = 0;
				for (i=0; i<256; i=i+1)
				begin
						clk = ~clk;
						data = $urandom%21845;//данные, что подаются в мультиплексор
						addr = i%16;//формирование адрессного входа

						if (data[addr]==out)
						begin
								$display("Okay");
						end
						else
						begin
								$display("Wrong");
						end
				end	
		end
		/*always @(posedge clk)
		begin
				if (data[addr]==out)
				begin
						$display("Okay");
				end
				else
				begin
						$display("Wrong");
				end
		end*/
endmodule