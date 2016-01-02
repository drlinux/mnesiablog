-module(erl_slug).
-compile(export_all).

slugify(String) ->
    slugify(String, []).

slugify([], Acc) -> Output = case Acc of [45 | T] -> T; _ -> Acc end, lists:reverse(Output);
slugify([C | Part], Acc) ->
    NewC = case C of
               C when C >= $0 andalso C =< $9 -> C;
               C when C > -1, C < 10 -> C; %%  Keep numbers same
               C when C > 96, C < 123 -> C; %% Keep lowercase as lowercase
               C when C > 64, C < 91 -> C + 32; %% made upercase to lowercase
               C when C =:= 131 -> 102;
               C when C =:= 138 -> 115;
               C when C =:= 140 -> 79;
               C when C =:= 142 -> 122;
               C when C =:= 154 -> 115;
               C when C =:= 156 -> 79;
               C when C =:= 158 -> 122;
               C when C =:= 159 -> 121;
               C when C =:= 192 -> 97;
               C when C =:= 193 -> 97;
               C when C =:= 194 -> 97;
               C when C =:= 195 -> 97;
               C when C =:= 196 -> 97;
               C when C =:= 197 -> 97;
               C when C =:= 198 -> 97;
               C when C =:= 200 -> 101;
               C when C =:= 201 -> 101;
               C when C =:= 202 -> 101;
               C when C =:= 203 -> 101;
               C when C =:= 204 -> 105;
               C when C =:= 205 -> 105;
               C when C =:= 206 -> 105;
               C when C =:= 207 -> 105;
               C when C =:= 208 -> 100;
               C when C =:= 209 -> 110;
               C when C =:= 210 -> 79;
               C when C =:= 211 -> 79;
               C when C =:= 212 -> 79;
               C when C =:= 213 -> 79;
               C when C =:= 216 -> 79;
               C when C =:= 217 -> 117;
               C when C =:= 218 -> 117;
               C when C =:= 219 -> 117;
               C when C =:= 221 -> 121;
               C when C =:= 222 -> 116;
               C when C =:= 223 -> 115;
               C when C =:= 224 -> 97;
               C when C =:= 225 -> 97;
               C when C =:= 226 -> 97;
               C when C =:= 227 -> 97;
               C when C =:= 228 -> 97;
               C when C =:= 229 -> 97;
               C when C =:= 230 -> 97;
               C when C =:= 232 -> 101;
               C when C =:= 233 -> 101;
               C when C =:= 234 -> 101;
               C when C =:= 235 -> 101;
               C when C =:= 236 -> 105;
               C when C =:= 237 -> 105;
               C when C =:= 238 -> 105;
               C when C =:= 239 -> 105;
               C when C =:= 240 -> 100;
               C when C =:= 241 -> 110;
               C when C =:= 242 -> 79;
               C when C =:= 243 -> 79;
               C when C =:= 244 -> 79;
               C when C =:= 245 -> 79;
               C when C =:= 248 -> 79;
               C when C =:= 249 -> 117;
               C when C =:= 250 -> 117;
               C when C =:= 251 -> 117;
               C when C =:= 253 -> 121;
               C when C =:= 254 -> 116;
               C when C =:= 255 -> 121;
               %% Turkish chracters
               C when C =:= 286 -> 103;
               C when C =:= 287 -> 103;
               C when C =:= 304 -> 105;
               C when C =:= 305 -> 105;
               C when C =:= 350 -> 115;
               C when C =:= 351 -> 115;
               _ -> 45 %% replace all other characters with an '-'
           end,
    NewAcc = case {NewC, Acc} of
                 {45, []} -> []; %% check '-' character
                 {45, [45 | _ ]} -> Acc; %% check duplicated '-' characters
                 _ -> [NewC | Acc]
             end,
    slugify(Part, NewAcc).
