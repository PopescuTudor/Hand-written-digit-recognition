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
## @deftypefn {} {@var{retval} =} magic_with_pca (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-08

function [train, miu, F, Vk] = magic_with_pca (train_mat, pcs)
  [m, n] = size (train_mat);
  
  % initializare train
  train = zeros (m, n);
  
  % initializare miu
  miu = zeros (1, n);
  
  % initializare F
  F = zeros (m, pcs);
  
  % initializare Vk
  Vk = zeros (n, pcs);
  
  %cast train_mat la double.
  train_mat = double(train_mat);
  %calculeaza media fiecarei coloane a matricii.
  miu = mean(train_mat, 1);
  %scade media din matricea initiala.
  train_mat = train_mat - miu;
  %calculeaza matricea de covarianta.
  cov_matrix = (train_mat' * train_mat) / (m - 1);
  %calculeaza vectorii (V) si valorile proprii (S) ale matricei de covarianta.
  [V, S] = eig(cov_matrix);
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
  %pastreaza doar primele pcs coloane din matricea obtinuta anterior.
  Vk = V_sort(:, 1:pcs);
  %creaza matricea F schimband baza matricii initiale.
  F = train_mat * Vk;
  %calculeaza matricea train care este o aproximatie a matricii initiale
  train = F * Vk';

endfunction
