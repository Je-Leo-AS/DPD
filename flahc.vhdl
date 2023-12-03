library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity garagem is
    Port ( remoto : in  STD_LOGIC;
           aberta : in  STD_LOGIC;
           fechada : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           ligar : out  STD_LOGIC;
           direcao : out  STD_LOGIC;
			  debug: out STD_LOGIC_VECTOR(5 downto 0));
end garagem;

architecture Behavioral of garagem is

type state is (st_fechado, st_aberto, abrindo, fechando, parado_abrindo, parado_fechando);
SIGNAL present_state, future_state: state;
SIGNAL estado_bt: STD_LOGIC;
SIGNAL pause: STD_LOGIC;
SIGNAL Useg_sig: integer range 0 to 10;
SIGNAL Dseg_sig: integer range 0 to 4;
SIGNAL flag: std_logic;
signal flag_timer: std_logic :='0';

component debounce is
	PORT(entrada: in std_logic;
		  clk: in std_logic;
		  saida: out std_logic);
end component;
component Timer is 
	PORT(rst: in STD_LOGIC;
	     clk: in STD_LOGIC;
		  pause: in STD_LOGIC;
		  Dseg: out integer;
		  Useg: out integer);
end component;

begin

bt: debounce port map(remoto, clk, estado_bt);
tempo: Timer PORT MAP(flag_timer, clk, pause, Dseg_sig, Useg_sig);

process(rst,clk)
begin
	if(rst='1') then
			present_state <= st_fechado;
	elsif rising_edge(clk) then
		present_state <= future_state;
	end if;
end process;

process(rst, estado_bt)
begin
if(rst='1') then
flag <= '0';
elsif(estado_bt'event and estado_bt='0') then
flag <= not(flag);
end if;
end process;

process (present_state, remoto, aberta, fechada, estado_bt, flag, Dseg_sig)
begin	
		--if(estado_bt='0') then 
			---flag <= '1';
		--flag <= '0';
		--end if;
		case present_state is
			when st_fechado => 
				ligar <= '0'; 
				direcao <= '0';
				pause <= '1';
				debug<= "000001";
				flag_timer <= '1';
				
				
				if(estado_bt = '1' and flag='0' AND aberta = '0' and fechada = '1' ) then
					future_state <= abrindo;
					--flag <= '0';
				else
					future_state <= st_fechado;
				end if;	
				
			when abrindo => 
				ligar <= '1'; 
				direcao <= '0';
				pause <= '1';
				debug<= "000010";
				flag_timer <= '1';
				
				
				if(estado_bt = '1' and aberta = '0' and fechada = '0' and flag='1') then
					future_state <= parado_abrindo;
					--flag <= '0';
				elsif(aberta = '1' and fechada = '0') then
					future_state <= st_aberto;
				else
					future_state <=abrindo;
				end if;			
				
			when st_aberto => 
				ligar <= '0'; 
				direcao <= '1';
				pause <= '0';
				debug<= "000100";
				flag_timer <= '0';
				
				if(estado_bt = '1' and  aberta = '1' and fechada = '0' and flag='1') then
					future_state <= fechando;
					--flag <= '0';
				elsif(Dseg_sig = 3) then
					future_state <= fechando;
					--flag <= '0';
				else
					future_state <= st_aberto;
				end if;
		
			when fechando => 
				ligar <= '1'; 
				direcao <= '1';
				pause <= '1';
				debug<= "001000";
				flag_timer <= '1';
				
				if(estado_bt = '1' and aberta = '0' and fechada = '0' and flag='1' ) then 
					future_state <= parado_fechando;
					--flag <= '0';
				elsif(fechada = '1' and aberta = '0') then
					future_state <= st_fechado;
				else
					future_state <= fechando;
				end if;

			when parado_abrindo => 
				ligar <= '0'; 
				direcao <= '1';
				pause <= '0';
				debug<= "010000";
				flag_timer <= '0';
			
				if(estado_bt = '1' and aberta = '0' and fechada = '0' and flag='1') then
					future_state <= fechando;
					--flag <= '0';
				elsif (Dseg_sig = 3) then
					future_state <= fechando;
					--flag <= '0';
				else
					future_state <= parado_abrindo;
				end if;

			when parado_fechando => 
				ligar <= '0'; 
				direcao <= '0';
				pause <= '0';
				debug<= "100000";
				flag_timer <= '0';
				
				if(estado_bt = '1' and aberta = '0' and fechada = '0' and flag='1') then
					future_state <= abrindo;
					--flag <= '0';
				elsif(Dseg_sig = 3) then
					future_state <= fechando;
					--flag <= '0';
				else 
					future_state <= parado_fechando;
				end if;
			
		end case;
end process;

end Behavioral;