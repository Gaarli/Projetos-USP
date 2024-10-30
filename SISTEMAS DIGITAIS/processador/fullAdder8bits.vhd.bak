library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fullAdder8bits is
    Port (
        A        : in  STD_LOGIC_VECTOR(7 downto 0);
        B        : in  STD_LOGIC_VECTOR(7 downto 0);
        Cin      : in  STD_LOGIC; -- Cin é um único bit para o carry-in
        Cout     : out STD_LOGIC_VECTOR(7 downto 0);
        SUM      : out STD_LOGIC_VECTOR(7 downto 0);
        overflow  : out STD_LOGIC
    );
end fullAdder8bits;

architecture Behavioral of fullAdder8bits is
    signal carry: STD_LOGIC_VECTOR(7 downto 0);
begin
    process(A, B, Cin)
    begin
        -- Bit 0
        SUM(0) <= (A(0) XOR B(0)) XOR Cin;
        Cout(0) <= (A(0) AND B(0)) OR ((A(0) XOR B(0)) AND Cin);
        
        -- Bit 1
        SUM(1) <= (A(1) XOR B(1)) XOR Cout(0);
        Cout(1) <= (A(1) AND B(1)) OR ((A(1) XOR B(1)) AND Cout(0));
        
        -- Bit 2
        SUM(2) <= (A(2) XOR B(2)) XOR Cout(1);
        Cout(2) <= (A(2) AND B(2)) OR ((A(2) XOR B(2)) AND Cout(1));
        
        -- Bit 3
        SUM(3) <= (A(3) XOR B(3)) XOR Cout(2);
        Cout(3) <= (A(3) AND B(3)) OR ((A(3) XOR B(3)) AND Cout(2));
        
        -- Bit 4
        SUM(4) <= (A(4) XOR B(4)) XOR Cout(3);
        Cout(4) <= (A(4) AND B(4)) OR ((A(4) XOR B(4)) AND Cout(3));
        
        -- Bit 5
        SUM(5) <= (A(5) XOR B(5)) XOR Cout(4);
        Cout(5) <= (A(5) AND B(5)) OR ((A(5) XOR B(5)) AND Cout(4));
        
        -- Bit 6
        SUM(6) <= (A(6) XOR B(6)) XOR Cout(5);
        Cout(6) <= (A(6) AND B(6)) OR ((A(6) XOR B(6)) AND Cout(5));
        
        -- Bit 7
        SUM(7) <= (A(7) XOR B(7)) XOR Cout(6);
        Cout(7) <= (A(7) AND B(7)) OR ((A(7) XOR B(7)) AND Cout(6));

        -- Cálculo do overflow
        overflow <= Cout(6) XOR Cout(7); -- Verifica o overflow
    end process;

end Behavioral;
