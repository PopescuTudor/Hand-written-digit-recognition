## Copyright (C) 2021 Andrei
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} pca_cov (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-06

function new_X = task3 (photo, pcs)
  [m, n] = size (photo);
  
  % initializare matrice finala.
  new_X = zeros (m, n);
  
  %cast photo la double.
  doublePhoto = double(photo);
  
  %calculeaza media fiecarui rand al matricii.
  mediaVector = mean(doublePhoto, 2);
  
  %normalizeaza matricea initiala scazand din ea media fiecarui rand.
  doublePhoto = doublePhoto - mediaVector;
  
  %calculeaza matricea de covarianta.
  Z = ( doublePhoto * doublePhoto' ) ./ (n-1);
  
  %calculeaza vectorii si valorile proprii ale matricei de covarianta.
  [V, S] = eig(Z);
  
  %ordoneaza descrescator valorile proprii si creaza o matrice V
  % formata din vectorii proprii asezati pe coloane, astfel incat prima coloana
  % sa fie vectorul propriu corespunzator celei mai mari valori proprii si
  % asa mai departe.
  [s_sort_vector, ind] = sort(diag(S), 'descend'); %Extrag elementele 
                  %din matricea diagonala S si le sortez descrescator
                  %Voi primi si un vector coloana ind cu indicii corespunzatori 
                  %elementelor initiale, in noua ordine 
  S_sort = S(ind, ind);
  V_sort = V(:, ind); %Cum acesti indici corespund si vectorilor proprii
                      %din V, putem sorta astfel si aceasta matrice
                      
  %pastreaza doar primele pcs coloane
  
  %primele coloane din V reprezinta componentele principale
  W = V_sort(:, 1:pcs);
  
  %creaza matricea Y schimband baza matricii initiale.
  Y = W' * doublePhoto;
  
  %calculeaza matricea new_X care este o aproximatie a matricii initiale
  %aduna media randurilor scazuta anterior.
  new_X = W*Y + mediaVector;
    
  %transforma matricea in uint8 pentru a fi o imagine valida.
  new_X = uint8(new_X);
endfunction
