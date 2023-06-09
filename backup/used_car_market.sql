PGDMP                         {            used_car_market    15.1    15.1     o           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            p           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            r           1262    16712    used_car_market    DATABASE     q   CREATE DATABASE used_car_market WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE used_car_market;
                postgres    false                        3079    16823    cube 	   EXTENSION     8   CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;
    DROP EXTENSION cube;
                   false            s           0    0    EXTENSION cube    COMMENT     E   COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';
                        false    2                        3079    16912    earthdistance 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;
    DROP EXTENSION earthdistance;
                   false    2            t           0    0    EXTENSION earthdistance    COMMENT     f   COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';
                        false    3                       1255    16928 T   euc_distance(double precision, double precision, double precision, double precision)    FUNCTION     �   CREATE FUNCTION public.euc_distance(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN sqrt((lat1 - lat2) ^ 2 + (lon1 - lon2) ^ 2);
END;
$$;
    DROP FUNCTION public.euc_distance(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision);
       public          postgres    false            �            1259    16765    advertisement    TABLE     )  CREATE TABLE public.advertisement (
    advertisement_id integer NOT NULL,
    product_id integer NOT NULL,
    user_id integer NOT NULL,
    is_allowed_bid boolean NOT NULL,
    title character varying(100) NOT NULL,
    description text,
    timestamp_ad timestamp without time zone NOT NULL
);
 !   DROP TABLE public.advertisement;
       public         heap    postgres    false            �            1259    16807    bid    TABLE       CREATE TABLE public.bid (
    bid_id integer NOT NULL,
    user_id integer NOT NULL,
    advertisement_id integer NOT NULL,
    price_bid integer NOT NULL,
    status_bid character varying(20) NOT NULL,
    timestamp_bid timestamp without time zone NOT NULL
);
    DROP TABLE public.bid;
       public         heap    postgres    false            �            1259    16743    car_product    TABLE     �   CREATE TABLE public.car_product (
    product_id integer NOT NULL,
    brand character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    body_type character varying(50) NOT NULL,
    year integer NOT NULL,
    price integer NOT NULL
);
    DROP TABLE public.car_product;
       public         heap    postgres    false            �            1259    16738    city    TABLE     �   CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying(50) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);
    DROP TABLE public.city;
       public         heap    postgres    false            �            1259    16760    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone_number character varying(20) NOT NULL,
    city_id integer NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            k          0    16765    advertisement 
   TABLE DATA           �   COPY public.advertisement (advertisement_id, product_id, user_id, is_allowed_bid, title, description, timestamp_ad) FROM stdin;
    public          postgres    false    219   �"       l          0    16807    bid 
   TABLE DATA           f   COPY public.bid (bid_id, user_id, advertisement_id, price_bid, status_bid, timestamp_bid) FROM stdin;
    public          postgres    false    220   �+       i          0    16743    car_product 
   TABLE DATA           W   COPY public.car_product (product_id, brand, model, body_type, year, price) FROM stdin;
    public          postgres    false    217   �3       h          0    16738    city 
   TABLE DATA           G   COPY public.city (city_id, city_name, latitude, longitude) FROM stdin;
    public          postgres    false    216   �5       j          0    16760    users 
   TABLE DATA           E   COPY public.users (user_id, name, phone_number, city_id) FROM stdin;
    public          postgres    false    218   87       �           2606    16771     advertisement advertisement_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT advertisement_pkey PRIMARY KEY (advertisement_id);
 J   ALTER TABLE ONLY public.advertisement DROP CONSTRAINT advertisement_pkey;
       public            postgres    false    219            �           2606    16811    bid bid_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_pkey PRIMARY KEY (bid_id);
 6   ALTER TABLE ONLY public.bid DROP CONSTRAINT bid_pkey;
       public            postgres    false    220            �           2606    16747    car_product car_product_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.car_product
    ADD CONSTRAINT car_product_pkey PRIMARY KEY (product_id);
 F   ALTER TABLE ONLY public.car_product DROP CONSTRAINT car_product_pkey;
       public            postgres    false    217            �           2606    16742    city city_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public            postgres    false    216            �           2606    16764    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    218            �           2606    16772 +   advertisement advertisement_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT advertisement_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.car_product(product_id);
 U   ALTER TABLE ONLY public.advertisement DROP CONSTRAINT advertisement_product_id_fkey;
       public          postgres    false    217    219    3534            �           2606    16777 (   advertisement advertisement_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT advertisement_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 R   ALTER TABLE ONLY public.advertisement DROP CONSTRAINT advertisement_user_id_fkey;
       public          postgres    false    218    219    3536            �           2606    16817    bid bid_advertisement_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_advertisement_id_fkey FOREIGN KEY (advertisement_id) REFERENCES public.advertisement(advertisement_id);
 G   ALTER TABLE ONLY public.bid DROP CONSTRAINT bid_advertisement_id_fkey;
       public          postgres    false    3538    220    219            �           2606    16812    bid bid_user_id_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 >   ALTER TABLE ONLY public.bid DROP CONSTRAINT bid_user_id_fkey;
       public          postgres    false    218    3536    220            �           2606    16797    users users_city_id_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_city_id_fk FOREIGN KEY (city_id) REFERENCES public.city(city_id);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_city_id_fk;
       public          postgres    false    216    218    3532            k   		  x�}Xˎ�H<��~��%��=Xc{ƞ��6Y�.@|�l��od�S=��%J������,D-.���ק'=hm|Q7�˹���>�|YnǺ�F�}�QM'���٥��9.�eS]hp����5kc��9��0'��B�#W��i]6���i�a1ݛ�(�|�뇲���+/]Ye%6ZW���e������rSض�GM�=��7�c�Z7��sj��I~�QT���K=˛~T���/�Į{:��m�xO�C~}�/�����kV��E.��w
پr�ԫ����2c=���I~�^�����r^��~?��?�]ю���w����k�iӣ^�����8;($�nEY4Ǽ��#�eĝ��0=���~E��gA5�,����2�Eum����z���ŕ�9&l��_�D{�K@F���{��#J0��*���[�:�2 CO�E��bC\�� f���N	�f�.��/>��_��,������Q���}&L�W�,-�s�e����&��s���f�vd�������eE]Pg�"J h�CH���1TP��Z0@�L0+��>wy����5�����k��H����:6���9Q���(Tk�R��C��
���ʳ̋.ǆ��,���$���+HMŧ�/�r�d��z5H�_���?�׆���!��p�O@�1��f��w�=�G`�P=��mCBt�o�ȼ�jh�9�����?�g���}����Ab�[tT�nL0=�Ȩ����-M=']�����Y^Pi)���*�JT������a6�� ��&����?"��P6=^��r�#.;�~�5��e)��F��O@*�W}S�1j�oV�^#�d��wW]W/���KW�]uɠ�u)�;�p@�]G�4!�7Z���a�TO�Dע��?I����R(���
* ,��aC��Z�Pg�����O��X(i���0R��t{x��_����"h1��/�����Pc�լ�&\q�!U�q�,�2z"�	�=�ߐ�	۱�\BS�����p�͝��ă�b���&��#����SB��;h�HE��~��2-)8�@Ug Lyq��z<��\b*<�jW8��߆g��&KB����ʶ۟��I>��[ a�#}a�z���:&{{��:`�U^������(Z4$�x�z<�T��D���OLy�C�jd�9ۦ��z8iZҪ-B�����-�sZ��)2�'v�P�/\�'9�����)Br^כ��D2�J8�=ߖ8�yh���yNԌ��kz�P� tu�!ke-��߸߻7׆��Jv2/3�=Z�4����Qs�k#wVT-Q�X����a�Nᖶ����kqb��c	�B	-QϢW�`���3�|U���N�-�]�|��M%�to��鯔/�I��yc#S��9��}�Y;�Y�T&o��"�Z4d��C��v�a炓�~Ԋck�Hi?t"i6!2C���0%߱������B���e�����eb_=m%�� Q���Cq�E��q�WQ�Elg��!��q�%U �� '5�Q��!1�Aܩ��MY?��>T9m��Qde.P��$�H�d_c�
H��9��������8<ye�G��jV���܀��/.a�C�����Is\��E�%���k��W��P	>���Q?���b�l�&z�����N�ϓ�u`c������W��j`Ĺ�&+K��]��' ��:�JG�Os�ӡU&a�aP��t�DK&����>�%Wo��lGC�^�5��~xv�"�V�]\��6�%���0H9R{<هa'�R�dA�����d�rsg�,����`W4�hS���ѵ ���/�}�E����A� GVP��N$;�d�ߥ�Z��wi@�����o�L4.�?�Ӫ�z�q�Rap7¢�|9 _w% ߈�!װ�/�������V�����쌻C����ٛ��	�`�0'�P�.�Ài��߉JT^ȋ1%ӊ�,�m��@��7�'�z�Ҏ�0��&�A͢�{x:{�B+ȫ�nAr��������m+�v�.9L�1Y5Zh/�~�y��F��M i"-���ĳM���	�0ҽy��g�9�x�e�+ҹH6P;O���"Z2P���{����6w3mҏ��ӓ-k&���P��[��a�.}���Ng9�Ŵ~�̎����j���z��2�]�^Ʊ L�+���M2����qH�c�Ɲ7(��ME�=xZ�}���?��_�I�;qm2���MZ/�)����/������vj$"]p�#9K���=��D(uK��<eY�_j��a      l   �  x�m�M�d���z���!��~r�����`�0^���/�3@�^u碁b��`0"�VҊYYm̕-ʟ��돯�|�R��?k>}<��2^闗h�G�Lϴ��_�ׯ���z<k{X{��b\Q�o�<����<<�n��_��:�V��,6"�X�tT���Qi�_W��B�9��G?:YO�����W/}�^"z���*�ߏ_��i�V�vp�]\oC>�0���ѡ�k>��l�z�.�Z���wuX莭^��^��z��dzU�-^1/�%��sMϨ:�����͗&D�	?gB#}�u�0�6��!���g��@{�o���� �et���y�?d��׿�~���A���4�-����.ɇ��K1Z�ky?������U�����P��V�.Ҍ=�iLi�F�(c~g&��5�@�\PQ �v1�bB�2f���}��P�>{�7�#V���>:aHB�^ yy-�6���h>Q܇���}]�� i�{�h ��]���m~A�9E03�F�cF�����y��V�k>��o(Ì�uC`���c���tt_���`C3eO댎^��J�χ�WGp�9��>�څ�D�ȈY��֖E]���)`�^�� �P�깩�k�`#䫶I�,0����G��n���������]]��;�q�j���F}]h���[�ަ} �ǤM�w�� �����r��ҵѴ�B}�\3+d�T<-��0���&!�����Ωv�n9�~�Y/��r-�8,�A�i�v��%9譛����v>�d#�S��;�*Q�:8r�YV����-؟�*Fd�9&v�ھ�'4�(�)b|���4�b;d�\v�"c��T�Խ�r%��Fl<l�b���O�D���P��4���7�Ty��Cw�wJ�JqT�����{�'/��!����G�s��v��,�I!�Ƨ���W���\�kU)��K1N����X����wLil\��/*y��������:���/L)'|�YW���[{�4����z��li��ێ)qg��x�������&F���T@}�4&s���Z��{2�H7䇾4���l���@@���[o�����VB�՝��[ahh�p��@}�ce�P�+��,p���{����kh5�>\��b��5M�*�W�rFԷ���ɯw�`L�$�W��Р��l��<I�6�&��ݠ�|����d{�ʙ,�t�}��s�MOm��������2�Z�yz�/�D�r\=DI�B0d57qJYY��[�o�Gm���[�$�I�������ʐd�&b��V�f��}���d��oL^P�s	Y9���ƚ�8�yG�TpWJ��O��� �6oA�KSQF0 �(�D�Q�VFDA~�2���sYSK�n޺D��2l��N<�����Zoh�@K��i�+��!M�����a�RZ���ݞ(ӛ�%�I��,k�ɺ�~W��m?jp���$�8�1�%�<�<�D_�2?8��ڜ��o�miz|��Im��{�Ev��V���E>�;�Yoԃ�'I��c�ά����g�v��i6Y�q.T�J	����R\�����m��p
x�L{��D����7����F�_P֋d�֚�=S��}a�mP����Upn�'RVm��IE[��3f�uw(�+�/=(�	�2���W"�_�-T�7�����!1��{���6ɐy��o"�xlK \ �h�8�Z���O��)9�����k1H͙�E�M`�	/T�	�%D�n�2��a��]�#e�p�"�0�
�N>/C�)�c�q���f���-�W��f���C��tג�+T����m[1_���{��A[mt;��D��zg嵐�։�9�8���-G�_����7���ː?2��	З��&�߂�6u�/6��p�n
�W��o���	(�f���"�A\��
��}*�G<�����N��u]����      i      x����j�@��GO�Hٝ��N 
%N�r�q�#,�O�~�N흍��Z�B��7�9sfW�}���5�����v���o�BZ�Έ��2�%㪌k���8
�D�ʔ�#H�	��z��m:��L�"�!��"LC��;�h$�Ɯ�XIQl�y�e��w��e�J��8{X�(�Yvؖ�n���!xβ�b�5X���k�nv���z��e�^q�UAF�V��)1,W�Q�	�9�K�
ʞ��źn60��x:z2�ڡNb�iH>���"N�-O���`�/�?�U��O��Ӿ���Q�v��m�&�*��m���K�՗j���L`Z�]�z����{<�ܤ�'�� @�u�rg�;�lh���V� +
�3l[�����3m���p1Jg�_���{;�	�Y@���b@�
>m�ng4�?�yw�*�]c=[���M&�@���H�g?ZH�-���@�;�0�vouzMn��z��B�,���,r�Q��mF� �g�ʈ� ˟��oUU�BTj�      h   `  x�U��j�@��)�:���f���%PH{X؋��`����y�Jv�/!�˯4&(н~O��u�Ϸ��S�"��*$��rj
>�IG]0B&^p)0;�g�1�&�Di���t�y�Iǔ�d�q�������_��%g��ƕ[ ����I�C�Rb�P[� 0

'rUW��G��Wu�����
ej5P������NwYZA��I�}������� ��ͥ%Y� t�|��R0�更(��,Nn���~���p����V,^�yT��?���{[���fm7Xj%r{�Н~��{�XN�L�����(��C_.j�f���1�b��>�/���ᬋ�QX�GsD��Z�C?�@��      j   �  x�]WKs7</�Q%���q��Ĵ-9�$;.�h�$$r��GT�O�KR)W�������GTֻ�Gv���&�կV�_����)m�2RVF81�է�?�.>}�wJ��bN^)��LU�7�sv=l�f���b�����ͼ���.��y�T�����n�nb�"�mc��_">�J]0�]���S��To�c�́}M��~�SŽ�A^X]Y�����9���l1�qw��7v?�}^ާ���B�e�ʙ���c�٬Q���I��K�e���u!�o��~-׏'��a�_)��,T��n=.;`��RH:O��>�vݰ/]���xm��u��qj&Du�J@�ݥ�،�Fs��R�༷C�i��Gq��ϱO���Þ�'�=�Vތo�ժ�|Ἆ?�خ�آft�./wk�CqM�]�Ш�{A��s�RƗ�L�x����U\���c# V(�Um�t�t[��j�j�N�vX+��t5@ �����M@0��TS���I���mn��#2�C�4"������{*���+q���q��g�(T�v3g�~{ �ٗ瘺�?ºZ]kd~:�t�n��u���4�P��)+x>#�At��}Vc3��NS�&�����&3�6DE���t��z��m$@Z�d�jQ�� �/�Ag�`^�U$�ϓ"��ڴ�@��$S���m| ��ա��|:>h���I?	_��Sd���rIz���Y����@D��"�C��;_��kt�����~|8<Ƕ9L��@�YC�
B��d����h�;�fz�⣁0�`�݊�݉}�˴��gw ��ۑ	�禖N�"�٣D�!v�Լ�HO�.b����/;@5�����T���PD�̫����CO:8u�D� �Bٵ�诒d�:���.�u]������UjeUm���=��T������O�.�:�N��M֟����>$r�Uzʅ���N��Eߡl�<|�����<VyZ��z�`3{��/O�D3�d��˖t	u>ĩ�ki,�!��i^�_�A�/%G�F��i�Bx�#���:���Zy���ZV�q�|����&��ebL0��;��ͺaHG��EX��`6y����w ӯ�;��tj G�Z<|�6��oI�'X���-����6OK���1���pRy��� �<s��?���'awH=��L�����j@����'��|�Ap���.�-��4���}^��	S;�C~�)2�+v�R ������Lu)�σ�p�:x��_N���!�s'r�FN�H��\J�û��Z��8�� i���.�L|A���芅����ز<<OhJH��i�M�c2�����9Hry�'΀���S�VB�4,�����p�f��%)G���>�[D(~8)WV��C�����b��v�C�х��P[��`A�t��f�6�ǅ�YNy/���PZ�4��@fE���5��=�!����9��|����p�k=�L�%"�/�
<��cd_��4�(��Z�q��R����	�_"���H&�ǰ!�6Yf�\j��#Ԑ�׵��T��"���`8�珱���{���Uw1m1�o`yb�� �C�ʩ�� m�  o��*�������ܳ��C|���w��S+��5Ec�
�T�ȱ7��sʾץ)IP�cdz�:SّG"l3r�}���M����JUk;٤��,����<�^�T���EqD�w�p�u/pP���q�kNW�6����TP�)ؖ\n�x�R ��״�Hظ�nF������Q�d�8`�R���\�Q���O� R�TP,H-�#�n?��.}?�Ғ�G�ӆ��d����`v�4ל��̀� ,�*$�d�X���Ih�"j;�3H^Lca������$d;D6�e��>n]ȶ�e8-QY_H`A&����^U�$�nh�-20Ln�񘧲װ�g��̘�tLJ��̑�4�J����1���)�\�~��"�[�ʔu��\���A�*{��~� w#��p����D����0&�6��T�TáL�%c�1 V�	G�q3	���Q	Ix9m�l�Ԅ�
�i��g���:����D���{����4�bCU"g��я����L����?a<5C#�:���9ܦ���;`M�d��;j��p>ʂ�h/���3�h�L�#�P� U����C[����iQ��%.(dΣJ�E�Q\?[����s-������Q���:_A
XK�0�ލ��ٖLy����[�6�I������&��^m�4o�ӴB=�=��f�{,+�     