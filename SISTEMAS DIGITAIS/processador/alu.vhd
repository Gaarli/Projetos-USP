library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
    Port (
		comando : in STD_LOGIC_VECTOR(3 downto 0);
		input1  : in STD_LOGIC_VECTOR(7 downto 0);
      input2  : in STD_LOGIC_VECTOR(7 downto 0);
		output  : out STD_LOGIC_VECTOR(7 downto 0);
		flag_0        : out STD_LOGIC;
		flag_overflow : out STD_LOGIC;
		flag_signal   : out STD_LOGIC;
		flag_carry    : out STD_LOGIC;
	 );
end alu;

architecture Behavioral of alu is
	--VARIAVEIS AUXILIARES DA SOMA
	signal SUM1   : std_logic_vector(7 downto 0);
	signal COUT1   : std_logic_vector(7 downto 0);
	signal overflow1   : std_logic_vector(7 downto 0);
	
	--VARIAVEIS AUXILIARES DA SUBTRACAO
	signal input2invertido   : std_logic_vector(7 downto 0);
	signal SUM2   : std_logic_vector(7 downto 0);
	signal COUT2   : std_logic_vector(7 downto 0);
	signal overflow2   : std_logic;


	--DEFININDO O COMPONENTE DO SOMADOR DE 8 BITS
	component fullAdder8bits
        port (
				  A        : in  STD_LOGIC_VECTOR(7 downto 0);
				  B        : in  STD_LOGIC_VECTOR(7 downto 0);
				  Cin      : in  STD_LOGIC; -- Cin é um único bit para o carry-in
				  Cout     : out STD_LOGIC_VECTOR(7 downto 0);
				  SUM      : out STD_LOGIC_VECTOR(7 downto 0);
				  overflow : out STD_LOGIC
        );
    end component;
	 
	 --DEFININDO O COMPONENTE DO COMPLEMENTO DE DOIS
	 --ESSE COMPLEMENTO INVERTE E SOMA 1
	 component complemento_de_dois
        port (
				  num           : in  STD_LOGIC_VECTOR(7 downto 0); -- Entrada de 8 bits
				  complemento   : out STD_LOGIC_VECTOR(7 downto 0)   -- Saída do complemento de dois
        );
    end component;
	 
begin
	--INSTANCIANDO O SOMADOR DE 8 BITS
	
	somar : fullAdder8bits
        port map (
            A        => input1,
				B        => input2,
				Cin      => '0',
				Cout     => COUT1,
				SUM      => SUM1,
				overflow => overflow1
        );
	
	--INSTANCIANDO O COMPLEMENTO DE 2 PARA PODER USAR NA SUBTRACAO
	complemento : complemento_de_dois
        port map (
            num         => input2,
				complemento => input2invertido
        );
		  
	--A SUBTRACAO É UMA SOMA ONDE O INPUT2 É INVERTIDO ATRAVES DO COMPLEMENTO DE 2
	subtrair : fullAdder8bits
        port map (
            A        => input1,
				B        => input2invertido,
				Cin      => '0',
				Cout     => COUT2,
				SUM      => SUM2,
				overflow => overflow2
        );
	
	--COM BASE NO COMANDO, DEFINE-SE A OPERACAO A SER REALIZADA
	process(comando)
	begin
		case comando is
			--"0000": SOMA
			when "0000" => output:= SUM1; -- RECEBE O VALOR DA SOMA
								flag_overflow := overflow1; -- RECEBE O OVERFLOW DA SOMA
								flag_carry    := COUT1(7); -- RECEBE O ULTIMO CARRY DA SOMA
			
			--"0001": SUBTRAI
			when "0001" => output:= input1-input2;
								flag_overflow := overflow2;
								flag_carry    := COUT2(7);
								
			when "0010" => output:= input1 AND input2; --FAZ AND DE BIT A BIT
			when "0011" => output:= input1 OR input2;  --FAZ OR DE BIT A BIT
			when "0100" => output:= NOT input1;        --INVERTE OS BITS DO VETOR
			when others => output:= '0';
	end process;
	
	--FLAGS AUXILIARES
	
	--FLAG 0 (VERIFICA SE O NUMERO RESULTADO É ZERO)
	if(output = "00000000") then
		flag_0:='1';
	end if;
	--FLAG DE SINAL (SE FOR 1 É NEGATIVO, SE FOR 0 É POSITIVO)
	if(output(7)=='1') then
		flag_signal:='1';
	else
		flag_signal:='0';
	end if;
	
end Behavioral;
