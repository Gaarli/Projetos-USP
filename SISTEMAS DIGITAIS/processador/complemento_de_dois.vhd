library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity complemento_de_dois is
    Port (
        num           : in  STD_LOGIC_VECTOR(7 downto 0); -- Entrada de 8 bits
        complemento   : out STD_LOGIC_VECTOR(7 downto 0)   -- Saída do complemento de dois
    );
end complemento_de_dois;

architecture Behavioral of complemento_de_dois is
begin
    process(num)
    begin
        -- Inverte os bits e adiciona 1
        complemento <= (not num) + "00000001"; 
    end process;

end Behavioral;
