PGDMP     9                    z            DB_for_eshop    15.0    15.0 {    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16420    DB_for_eshop    DATABASE     �   CREATE DATABASE "DB_for_eshop" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Greek_Greece.1253';
    DROP DATABASE "DB_for_eshop";
                postgres    false                        3079    16486 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            �            1259    16535 	   discounts    TABLE     �   CREATE TABLE public.discounts (
    id integer NOT NULL,
    productid integer,
    value real,
    dateofcreation timestamp without time zone DEFAULT now(),
    description character varying(500)
);
    DROP TABLE public.discounts;
       public         heap    postgres    false                       1255    17558    delete_from_discounts(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_from_discounts(IN deletionid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 DELETE FROM public.discounts
   WHERE (discounts.id = delete_from_discounts.deletionid);
END;
 D   DROP PROCEDURE public.delete_from_discounts(IN deletionid integer);
       public          postgres    false    222            �            1259    16549    orderproducts    TABLE     �   CREATE TABLE public.orderproducts (
    id integer NOT NULL,
    orderno uuid,
    productid integer,
    quantity integer,
    ordervalue real
);
 !   DROP TABLE public.orderproducts;
       public         heap    postgres    false            +           1255    16711 "   delete_from_orderproducts(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_from_orderproducts(IN queryid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 DELETE FROM public.orderproducts
   WHERE (orderproducts.id = delete_from_orderproducts.queryid);
END;
 E   DROP PROCEDURE public.delete_from_orderproducts(IN queryid integer);
       public          postgres    false    224            �            1259    16497    orders    TABLE       CREATE TABLE public.orders (
    orderno uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    orderdate timestamp without time zone DEFAULT now(),
    fname character varying(50) NOT NULL,
    lname character varying(50) NOT NULL,
    comments character varying(200)
);
    DROP TABLE public.orders;
       public         heap    postgres    false    2            '           1255    16707    delete_from_orders(uuid) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_from_orders(IN queryid uuid)
    LANGUAGE sql
    BEGIN ATOMIC
 DELETE FROM public.orders
   WHERE (orders.orderno = delete_from_orders.queryid);
END;
 ;   DROP PROCEDURE public.delete_from_orders(IN queryid uuid);
       public          postgres    false    217            �            1259    16505    products    TABLE     �   CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    price real,
    dateofcreation timestamp without time zone DEFAULT now(),
    description character varying(500)
);
    DROP TABLE public.products;
       public         heap    postgres    false                       1255    16692    delete_from_products(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_from_products(IN deletionid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 DELETE FROM public.products
   WHERE (products.id = delete_from_products.deletionid);
END;
 C   DROP PROCEDURE public.delete_from_products(IN deletionid integer);
       public          postgres    false    219            �            1259    16523    useraddress    TABLE     U  CREATE TABLE public.useraddress (
    userid integer NOT NULL,
    country character varying(100) NOT NULL,
    region character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    street character varying(100) NOT NULL,
    number integer NOT NULL,
    postalcode character varying(50) NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.useraddress;
       public         heap    postgres    false            "           1255    16703     delete_from_useraddress(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_from_useraddress(IN deletionid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 DELETE FROM public.useraddress
   WHERE (useraddress.id = delete_from_useraddress.deletionid);
END;
 F   DROP PROCEDURE public.delete_from_useraddress(IN deletionid integer);
       public          postgres    false    220            �            1259    16471    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phonenumber character varying(100) NOT NULL,
    fname character varying(100) NOT NULL,
    lname character varying(100) NOT NULL,
    age integer NOT NULL,
    dateofcreation timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false                       1255    16699    delete_from_users(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.delete_from_users(IN deletionid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 DELETE FROM public.users
   WHERE (users.id = delete_from_users.deletionid);
END;
 @   DROP PROCEDURE public.delete_from_users(IN deletionid integer);
       public          postgres    false    216            .           1255    16815    get_discount_logs()    FUNCTION     l  CREATE FUNCTION public.get_discount_logs() RETURNS TABLE(id integer, productid integer, value real, description character varying, inserted_on timestamp without time zone, updated_on timestamp without time zone, deleted_on timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        discount_logs;
END; 
$$;
 *   DROP FUNCTION public.get_discount_logs();
       public          postgres    false            &           1255    16718    get_discounts()    FUNCTION       CREATE FUNCTION public.get_discounts() RETURNS TABLE(id integer, productid integer, value real, dateofcreation timestamp without time zone, description character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        discounts;
END; $$;
 &   DROP FUNCTION public.get_discounts();
       public          postgres    false            �            1255    16725 '   get_id_with_username(character varying)    FUNCTION       CREATE FUNCTION public.get_id_with_username(usernameins character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$ 
DECLARE idToGet int;
BEGIN
        SELECT  id INTO idToGet
        FROM    users
        WHERE   username = $1;

        RETURN idToGet;
END;
$_$;
 J   DROP FUNCTION public.get_id_with_username(usernameins character varying);
       public          postgres    false            �            1255    16720    get_order_products()    FUNCTION     �   CREATE FUNCTION public.get_order_products() RETURNS TABLE(id integer, orderno uuid, productid integer, quantity integer, ordervalue real)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        orderproducts;
END; $$;
 +   DROP FUNCTION public.get_order_products();
       public          postgres    false            0           1255    16817    get_order_products_logs()    FUNCTION     }  CREATE FUNCTION public.get_order_products_logs() RETURNS TABLE(id integer, orderno uuid, productid integer, quantity integer, ordervalue real, inserted_on timestamp without time zone, updated_on timestamp without time zone, deleted_on timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        orderproducts_logs;
END; 
$$;
 0   DROP FUNCTION public.get_order_products_logs();
       public          postgres    false            �            1255    16719    get_orders()    FUNCTION       CREATE FUNCTION public.get_orders() RETURNS TABLE(orderno uuid, orderdate timestamp without time zone, fname character varying, lname character varying, comments character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        orders;
END; $$;
 #   DROP FUNCTION public.get_orders();
       public          postgres    false            /           1255    16816    get_orders_logs()    FUNCTION     y  CREATE FUNCTION public.get_orders_logs() RETURNS TABLE(orderno uuid, fname character varying, lname character varying, comments character varying, inserted_on timestamp without time zone, updated_on timestamp without time zone, deleted_on timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        order_logs;
END; 
$$;
 (   DROP FUNCTION public.get_orders_logs();
       public          postgres    false            -           1255    16814    get_product_logs()    FUNCTION     o  CREATE FUNCTION public.get_product_logs() RETURNS TABLE(id integer, name character varying, price real, description character varying, inserted_on timestamp without time zone, updated_on timestamp without time zone, deleted_on timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        product_logs;
END; 
$$;
 )   DROP FUNCTION public.get_product_logs();
       public          postgres    false            �            1255    16726 *   get_productid_with_name(character varying)    FUNCTION       CREATE FUNCTION public.get_productid_with_name(nameins character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$ 
DECLARE idToGet int;
BEGIN
        SELECT  id INTO idToGet
        FROM    Products
        WHERE   name = $1;

        RETURN idToGet;
END;
$_$;
 I   DROP FUNCTION public.get_productid_with_name(nameins character varying);
       public          postgres    false            �            1255    16729     get_productname_with_id(integer)    FUNCTION       CREATE FUNCTION public.get_productname_with_id(idins integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$ 
DECLARE nameToGet varchar;
BEGIN
        SELECT  name INTO nameToGet
        FROM    Products
        WHERE   id = $1;

        RETURN nameToGet;
END;
$_$;
 =   DROP FUNCTION public.get_productname_with_id(idins integer);
       public          postgres    false            #           1255    16714    get_products()    FUNCTION       CREATE FUNCTION public.get_products() RETURNS TABLE(id integer, name character varying, price real, dateofcreation timestamp without time zone, description character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        products;
END; $$;
 %   DROP FUNCTION public.get_products();
       public          postgres    false            %           1255    16717    get_useraddress()    FUNCTION     F  CREATE FUNCTION public.get_useraddress() RETURNS TABLE(userid integer, country character varying, region character varying, city character varying, street character varying, number integer, postalcode character varying, id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
	select * 
	from useraddress;
END; $$;
 (   DROP FUNCTION public.get_useraddress();
       public          postgres    false            1           1255    16818    get_useraddress_logs()    FUNCTION     �  CREATE FUNCTION public.get_useraddress_logs() RETURNS TABLE(userid integer, country character varying, region character varying, city character varying, street character varying, number integer, postalcode character varying, id integer, inserted_on timestamp without time zone, updated_on timestamp without time zone, deleted_on timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
	select * 
	from useraddress_logs;
END; 
$$;
 -   DROP FUNCTION public.get_useraddress_logs();
       public          postgres    false            �            1255    16722    get_username_with_id(integer)    FUNCTION     $  CREATE FUNCTION public.get_username_with_id(idins integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$ 
DECLARE usernameToGet varchar(100);
BEGIN
        SELECT  username INTO usernameToGet
        FROM    users
        WHERE   id = $1;

        RETURN usernameToGet;
END;
$_$;
 :   DROP FUNCTION public.get_username_with_id(idins integer);
       public          postgres    false            $           1255    16715    get_users()    FUNCTION       CREATE FUNCTION public.get_users() RETURNS TABLE(id integer, username character varying, password character varying, email character varying, phonenumber character varying, fname character varying, lname character varying, age integer, dateofcreation timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        users;
END; $$;
 "   DROP FUNCTION public.get_users();
       public          postgres    false                       1255    16813    get_users_logs()    FUNCTION     �  CREATE FUNCTION public.get_users_logs() RETURNS TABLE(id integer, username character varying, password character varying, email character varying, phonenumber character varying, fname character varying, lname character varying, age integer, inserted_on timestamp without time zone, updated_on timestamp without time zone, deleted_on timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT
       *
    FROM
        users_logs;
END; 
$$;
 '   DROP FUNCTION public.get_users_logs();
       public          postgres    false                       1255    16691 7   insert_into_discounts(integer, real, character varying) 	   PROCEDURE     G  CREATE PROCEDURE public.insert_into_discounts(IN productid integer, IN value real, IN description character varying)
    LANGUAGE sql
    BEGIN ATOMIC
 INSERT INTO public.discounts (productid, value, description)
   VALUES (insert_into_discounts.productid, insert_into_discounts.value, insert_into_discounts.description);
END;
 t   DROP PROCEDURE public.insert_into_discounts(IN productid integer, IN value real, IN description character varying);
       public          postgres    false    222    222    222            )           1255    16709 7   insert_into_orderproducts(uuid, integer, integer, real) 	   PROCEDURE     �  CREATE PROCEDURE public.insert_into_orderproducts(IN ordernoins uuid, IN productidins integer, IN quantityins integer, IN ordervalueins real)
    LANGUAGE sql
    BEGIN ATOMIC
 INSERT INTO public.orderproducts (orderno, productid, quantity, ordervalue)
   VALUES (insert_into_orderproducts.ordernoins, insert_into_orderproducts.productidins, insert_into_orderproducts.quantityins, insert_into_orderproducts.ordervalueins);
END;
 �   DROP PROCEDURE public.insert_into_orderproducts(IN ordernoins uuid, IN productidins integer, IN quantityins integer, IN ordervalueins real);
       public          postgres    false    224    224    224    224                       1255    16705 K   insert_into_orders(character varying, character varying, character varying) 	   PROCEDURE     L  CREATE PROCEDURE public.insert_into_orders(IN fnameins character varying, IN lnameins character varying, IN commentsins character varying)
    LANGUAGE sql
    BEGIN ATOMIC
 INSERT INTO public.orders (fname, lname, comments)
   VALUES (insert_into_orders.fnameins, insert_into_orders.lnameins, insert_into_orders.commentsins);
END;
 �   DROP PROCEDURE public.insert_into_orders(IN fnameins character varying, IN lnameins character varying, IN commentsins character varying);
       public          postgres    false    217    217    217            ,           1255    16779 @   insert_into_products(character varying, real, character varying) 	   PROCEDURE     O  CREATE PROCEDURE public.insert_into_products(IN nameins character varying, IN priceins real, IN descriptionins character varying)
    LANGUAGE sql
    BEGIN ATOMIC
 INSERT INTO public.products (name, price, description)
   VALUES (insert_into_products.nameins, insert_into_products.priceins, insert_into_products.descriptionins);
END;
 �   DROP PROCEDURE public.insert_into_products(IN nameins character varying, IN priceins real, IN descriptionins character varying);
       public          postgres    false    219    219    219            (           1255    16708 �   insert_into_useraddress(integer, character varying, character varying, character varying, character varying, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.insert_into_useraddress(IN useridins integer, IN countryins character varying, IN regionins character varying, IN cityins character varying, IN streetins character varying, IN numberins integer, IN postalcode character varying)
    LANGUAGE sql
    BEGIN ATOMIC
 INSERT INTO public.useraddress (userid, country, region, city, street, number, postalcode)
   VALUES (insert_into_useraddress.useridins, insert_into_useraddress.countryins, insert_into_useraddress.regionins, insert_into_useraddress.cityins, insert_into_useraddress.streetins, insert_into_useraddress.numberins, insert_into_useraddress.postalcode);
END;
 �   DROP PROCEDURE public.insert_into_useraddress(IN useridins integer, IN countryins character varying, IN regionins character varying, IN cityins character varying, IN streetins character varying, IN numberins integer, IN postalcode character varying);
       public          postgres    false    220    220    220    220    220    220    220                       1255    16697 �   insert_into_users(character varying, character varying, character varying, character varying, character varying, character varying, integer) 	   PROCEDURE     Z  CREATE PROCEDURE public.insert_into_users(IN usernameins character varying, IN passwordins character varying, IN emailins character varying, IN phonenumberins character varying, IN fnameins character varying, IN lnameins character varying, IN ageins integer)
    LANGUAGE sql
    BEGIN ATOMIC
 INSERT INTO public.users (username, password, email, phonenumber, fname, lname, age)
   VALUES (insert_into_users.usernameins, insert_into_users.passwordins, insert_into_users.emailins, insert_into_users.phonenumberins, insert_into_users.fnameins, insert_into_users.lnameins, insert_into_users.ageins);
END;
   DROP PROCEDURE public.insert_into_users(IN usernameins character varying, IN passwordins character varying, IN emailins character varying, IN phonenumberins character varying, IN fnameins character varying, IN lnameins character varying, IN ageins integer);
       public          postgres    false    216    216    216    216    216    216    216                       1255    16809    log_delete_discount()    FUNCTION       CREATE FUNCTION public.log_delete_discount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO discount_logs (id, productid, value, description,deleted_on)
	SELECT id, productid, value, description,now()
	FROM discounts
	where id = old.id;
RETURN old;
END;
$$;
 ,   DROP FUNCTION public.log_delete_discount();
       public          postgres    false                       1255    16785    log_delete_order()    FUNCTION       CREATE FUNCTION public.log_delete_order() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
		 	INSERT INTO order_logs (orderno,fname, lname, comments,deleted_on)
			SELECT orderno,fname, lname, comments,now()
			FROM orders
			where orderno = old.orderno;
RETURN old;
END;
$$;
 )   DROP FUNCTION public.log_delete_order();
       public          postgres    false                       1255    16800    log_delete_orderproducts()    FUNCTION     9  CREATE FUNCTION public.log_delete_orderproducts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO orderproducts_logs (id, orderno, productid, quantity, ordervalue,deleted_on)
	SELECT id, orderno, productid, quantity, ordervalue,now()
	FROM orderproducts
	where id = old.id;
RETURN old;
END;
$$;
 1   DROP FUNCTION public.log_delete_orderproducts();
       public          postgres    false                       1255    16777    log_delete_product()    FUNCTION       CREATE FUNCTION public.log_delete_product() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
		 	INSERT INTO product_logs (id, name, price,description,deleted_on)
			SELECT id, name, price,description,now()
			FROM products
			where id = old.id;
RETURN old;
END;
$$;
 +   DROP FUNCTION public.log_delete_product();
       public          postgres    false                       1255    16753    log_delete_user_changes()    FUNCTION     E  CREATE FUNCTION public.log_delete_user_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
		 	INSERT INTO users_logs (id,username,password,email,phonenumber,fname,lname,age,deleted_on)
			SELECT id,username,password,email,phonenumber,fname,lname,age,now()
			FROM users
			where id = old.id;
RETURN old;
END;
$$;
 0   DROP FUNCTION public.log_delete_user_changes();
       public          postgres    false                       1255    16766    log_delete_useraddress()    FUNCTION     `  CREATE FUNCTION public.log_delete_useraddress() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
		 	INSERT INTO useraddress_logs (userid, country, region, city, street, number, postalcode, id,deleted_on)
			SELECT userid, country, region, city, street, "number", postalcode, id,now()
			FROM useraddress
			where id = old.id;
RETURN old;
END;
$$;
 /   DROP FUNCTION public.log_delete_useraddress();
       public          postgres    false            �            1255    16673    log_fname_changes()    FUNCTION     �   CREATE FUNCTION public.log_fname_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.fname <> OLD.fname THEN
		 INSERT INTO userlogtable(userid,created)
		 VALUES(1,1);
	END IF;

	RETURN NEW;
END;
$$;
 *   DROP FUNCTION public.log_fname_changes();
       public          postgres    false                       1255    16807    log_insert_discount()    FUNCTION       CREATE FUNCTION public.log_insert_discount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO discount_logs (id, productid, value, description,inserted_on)
	SELECT id, productid, value, description,now()
	FROM discounts
	where id = new.id;
	RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.log_insert_discount();
       public          postgres    false                       1255    16783    log_insert_order()    FUNCTION       CREATE FUNCTION public.log_insert_order() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO order_logs (orderno,fname, lname, comments,inserted_on)
	SELECT orderno,fname, lname, comments,now()
	FROM orders
	where orderno = new.orderno;
	RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.log_insert_order();
       public          postgres    false                       1255    16796    log_insert_orderproducts()    FUNCTION     ;  CREATE FUNCTION public.log_insert_orderproducts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO orderproducts_logs (id, orderno, productid, quantity, ordervalue,inserted_on)
	SELECT id, orderno, productid, quantity, ordervalue,now()
	FROM orderproducts
	where id = new.id;
	RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.log_insert_orderproducts();
       public          postgres    false            �            1255    16773    log_insert_product()    FUNCTION       CREATE FUNCTION public.log_insert_product() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO product_logs (id, name, price,description,inserted_on)
	SELECT id, name, price,description,now()
	FROM products
	where id = new.id;
	RETURN NEW;
END;
$$;
 +   DROP FUNCTION public.log_insert_product();
       public          postgres    false                       1255    16757    log_insert_user()    FUNCTION     6  CREATE FUNCTION public.log_insert_user() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO users_logs (id,username,password,email,phonenumber,fname,lname,age,inserted_on)
	SELECT id,username,password,email,phonenumber,fname,lname,age,now()
	FROM users
	where id = new.id;
	RETURN NEW;
END;
$$;
 (   DROP FUNCTION public.log_insert_user();
       public          postgres    false            	           1255    16762    log_insert_useraddress()    FUNCTION     Y  CREATE FUNCTION public.log_insert_useraddress() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO useraddress_logs (userid, country, region, city, street, number, postalcode, id,inserted_on)
	SELECT userid, country, region, city, street, "number", postalcode, id,now()
	FROM useraddress
	where id = new.id;
	RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.log_insert_useraddress();
       public          postgres    false                       1255    16808    log_update_discount()    FUNCTION     #  CREATE FUNCTION public.log_update_discount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW<>OLD THEN
		 INSERT INTO discount_logs (id, productid, value, description,updated_on)
		 VALUES(OLD.id, OLD.productid, OLD.value, OLD.description,now());
	END IF;
	RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.log_update_discount();
       public          postgres    false                       1255    16784    log_update_order()    FUNCTION       CREATE FUNCTION public.log_update_order() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW<>OLD THEN
		 INSERT INTO order_logs (orderno,fname, lname, comments,updated_on)
		 VALUES(OLD.orderno, OLD.fname, OLD.lname, OLD.comments,now());
	END IF;
	RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.log_update_order();
       public          postgres    false                       1255    16797    log_update_orderproducts()    FUNCTION     E  CREATE FUNCTION public.log_update_orderproducts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW<>OLD THEN
		 INSERT INTO orderproducts_logs (id, orderno, productid, quantity, ordervalue,updated_on)
		 VALUES(OLD.id,OLD.orderno, OLD.productid,OLD.quantity, OLD.ordervalue,now());
	END IF;
	RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.log_update_orderproducts();
       public          postgres    false            �            1255    16775    log_update_product()    FUNCTION       CREATE FUNCTION public.log_update_product() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW<>OLD THEN
		 INSERT INTO product_logs (id, name, price,description,updated_on)
		 VALUES(OLD.id, OLD.name, OLD.price, OLD.description,now());
	END IF;
	RETURN NEW;
END;
$$;
 +   DROP FUNCTION public.log_update_product();
       public          postgres    false            �            1255    16738    log_update_user_changes()    FUNCTION     ]  CREATE FUNCTION public.log_update_user_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW<>OLD THEN
		 INSERT INTO users_logs(id,username,password,email,phonenumber,fname,lname,age,updated_on)
		 VALUES(OLD.id,OLD.username,OLD.password,OLD.email,OLD.phonenumber,OLD.fname,OLD.lname,OLD.age,now());
	END IF;
	RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.log_update_user_changes();
       public          postgres    false            
           1255    16764    log_update_useraddress()    FUNCTION     q  CREATE FUNCTION public.log_update_useraddress() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW<>OLD THEN
		 INSERT INTO useraddress_logs (userid, country, region, city, street, number, postalcode, id,updated_on)
		 VALUES(OLD.userid, OLD.country, OLD.region, OLD.city, OLD.street, OLD.number, OLD.postalcode, OLD.id,now());
	END IF;
	RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.log_update_useraddress();
       public          postgres    false                       1255    16695 2   update_discounts(integer, real, character varying) 	   PROCEDURE     M  CREATE PROCEDURE public.update_discounts(IN queryid integer, IN updatedvalue real, IN updateddescription character varying)
    LANGUAGE sql
    BEGIN ATOMIC
 UPDATE public.discounts SET value = update_discounts.updatedvalue, description = update_discounts.updateddescription
   WHERE (discounts.id = update_discounts.queryid);
END;
 {   DROP PROCEDURE public.update_discounts(IN queryid integer, IN updatedvalue real, IN updateddescription character varying);
       public          postgres    false    222    222    222            *           1255    16710 ;   update_orderproducts(uuid, integer, integer, real, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.update_orderproducts(IN ordernoupd uuid, IN productidupd integer, IN quantityupd integer, IN ordervalueupd real, IN queryid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 UPDATE public.orderproducts SET orderno = update_orderproducts.ordernoupd, productid = update_orderproducts.productidupd, quantity = update_orderproducts.quantityupd, ordervalue = update_orderproducts.ordervalueupd
   WHERE (orderproducts.id = update_orderproducts.queryid);
END;
 �   DROP PROCEDURE public.update_orderproducts(IN ordernoupd uuid, IN productidupd integer, IN quantityupd integer, IN ordervalueupd real, IN queryid integer);
       public          postgres    false    224    224    224    224    224                        1255    16706 L   update_orders(character varying, character varying, character varying, uuid) 	   PROCEDURE     p  CREATE PROCEDURE public.update_orders(IN fnameupd character varying, IN lnameupd character varying, IN commentsupd character varying, IN queryid uuid)
    LANGUAGE sql
    BEGIN ATOMIC
 UPDATE public.orders SET fname = update_orders.fnameupd, lname = update_orders.lnameupd, comments = update_orders.commentsupd
   WHERE (orders.orderno = update_orders.queryid);
END;
 �   DROP PROCEDURE public.update_orders(IN fnameupd character varying, IN lnameupd character varying, IN commentsupd character varying, IN queryid uuid);
       public          postgres    false    217    217    217    217                       1255    16696 D   update_products(character varying, real, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.update_products(IN updatedname character varying, IN updatedprice real, IN updateddescription character varying, IN queryid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 UPDATE public.products SET name = update_products.updatedname, price = update_products.updatedprice, description = update_products.updateddescription
   WHERE (products.id = update_products.queryid);
END;
 �   DROP PROCEDURE public.update_products(IN updatedname character varying, IN updatedprice real, IN updateddescription character varying, IN queryid integer);
       public          postgres    false    219    219    219    219            !           1255    16702 �   update_useraddress(integer, character varying, character varying, character varying, character varying, integer, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.update_useraddress(IN useridupd integer, IN countryupd character varying, IN regionupd character varying, IN cityupd character varying, IN streetupd character varying, IN numberupd integer, IN postalcodeupd character varying, IN queryid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 UPDATE public.useraddress SET userid = update_useraddress.useridupd, country = update_useraddress.countryupd, region = update_useraddress.regionupd, city = update_useraddress.cityupd, street = update_useraddress.streetupd, number = update_useraddress.numberupd, postalcode = update_useraddress.postalcodeupd
   WHERE (useraddress.id = update_useraddress.queryid);
END;
   DROP PROCEDURE public.update_useraddress(IN useridupd integer, IN countryupd character varying, IN regionupd character varying, IN cityupd character varying, IN streetupd character varying, IN numberupd integer, IN postalcodeupd character varying, IN queryid integer);
       public          postgres    false    220    220    220    220    220    220    220    220                       1255    16698 �   update_users(character varying, character varying, character varying, character varying, character varying, character varying, integer, integer) 	   PROCEDURE     j  CREATE PROCEDURE public.update_users(IN usernameupd character varying, IN passwordupd character varying, IN emailupd character varying, IN phonenumberupd character varying, IN fnameupd character varying, IN lnameupd character varying, IN ageupd integer, IN queryid integer)
    LANGUAGE sql
    BEGIN ATOMIC
 UPDATE public.users SET username = update_users.usernameupd, password = update_users.passwordupd, email = update_users.emailupd, phonenumber = update_users.phonenumberupd, fname = update_users.fnameupd, lname = update_users.lnameupd, age = update_users.ageupd
   WHERE (users.id = update_users.queryid);
END;
   DROP PROCEDURE public.update_users(IN usernameupd character varying, IN passwordupd character varying, IN emailupd character varying, IN phonenumberupd character varying, IN fnameupd character varying, IN lnameupd character varying, IN ageupd integer, IN queryid integer);
       public          postgres    false    216    216    216    216    216    216    216    216            �            1259    16802    discount_logs    TABLE     
  CREATE TABLE public.discount_logs (
    id integer,
    productid integer,
    value real,
    description character varying(500),
    inserted_on timestamp without time zone,
    updated_on timestamp without time zone,
    deleted_on timestamp without time zone
);
 !   DROP TABLE public.discount_logs;
       public         heap    postgres    false            �            1259    16534    discounts_id_seq    SEQUENCE     �   ALTER TABLE public.discounts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.discounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    222            �            1259    16780 
   order_logs    TABLE     !  CREATE TABLE public.order_logs (
    orderno uuid,
    fname character varying(50),
    lname character varying(50),
    comments character varying(200),
    inserted_on timestamp without time zone,
    updated_on timestamp without time zone,
    deleted_on timestamp without time zone
);
    DROP TABLE public.order_logs;
       public         heap    postgres    false            �            1259    16548    orderproducts_id_seq    SEQUENCE     �   ALTER TABLE public.orderproducts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orderproducts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    224            �            1259    16792    orderproducts_logs    TABLE       CREATE TABLE public.orderproducts_logs (
    id integer,
    orderno uuid,
    productid integer,
    quantity integer,
    ordervalue real,
    inserted_on timestamp without time zone,
    updated_on timestamp without time zone,
    deleted_on timestamp without time zone
);
 &   DROP TABLE public.orderproducts_logs;
       public         heap    postgres    false            �            1259    16768    product_logs    TABLE     %  CREATE TABLE public.product_logs (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    price real,
    description character varying(500),
    inserted_on timestamp without time zone,
    updated_on timestamp without time zone,
    deleted_on timestamp without time zone
);
     DROP TABLE public.product_logs;
       public         heap    postgres    false            �            1259    16504    products_id_seq    SEQUENCE     �   ALTER TABLE public.products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    16682    useraddress_id_seq    SEQUENCE     �   ALTER TABLE public.useraddress ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.useraddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    16759    useraddress_logs    TABLE     �  CREATE TABLE public.useraddress_logs (
    userid integer NOT NULL,
    country character varying(100) NOT NULL,
    region character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    street character varying(100) NOT NULL,
    number integer NOT NULL,
    postalcode character varying(50) NOT NULL,
    id integer NOT NULL,
    inserted_on timestamp without time zone,
    updated_on timestamp without time zone,
    deleted_on timestamp without time zone
);
 $   DROP TABLE public.useraddress_logs;
       public         heap    postgres    false            �            1259    16470    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    216            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    215            �            1259    16748 
   users_logs    TABLE     �  CREATE TABLE public.users_logs (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phonenumber character varying(100) NOT NULL,
    fname character varying(100) NOT NULL,
    lname character varying(100) NOT NULL,
    age integer NOT NULL,
    inserted_on timestamp without time zone,
    updated_on timestamp without time zone,
    deleted_on timestamp without time zone
);
    DROP TABLE public.users_logs;
       public         heap    postgres    false            �           2604    16474    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            �          0    16802    discount_logs 
   TABLE DATA           o   COPY public.discount_logs (id, productid, value, description, inserted_on, updated_on, deleted_on) FROM stdin;
    public          postgres    false    231   ��       �          0    16535 	   discounts 
   TABLE DATA           V   COPY public.discounts (id, productid, value, dateofcreation, description) FROM stdin;
    public          postgres    false    222   I�       �          0    16780 
   order_logs 
   TABLE DATA           j   COPY public.order_logs (orderno, fname, lname, comments, inserted_on, updated_on, deleted_on) FROM stdin;
    public          postgres    false    229   ��       �          0    16549    orderproducts 
   TABLE DATA           U   COPY public.orderproducts (id, orderno, productid, quantity, ordervalue) FROM stdin;
    public          postgres    false    224   ��       �          0    16792    orderproducts_logs 
   TABLE DATA              COPY public.orderproducts_logs (id, orderno, productid, quantity, ordervalue, inserted_on, updated_on, deleted_on) FROM stdin;
    public          postgres    false    230   K�       �          0    16497    orders 
   TABLE DATA           L   COPY public.orders (orderno, orderdate, fname, lname, comments) FROM stdin;
    public          postgres    false    217    �       �          0    16768    product_logs 
   TABLE DATA           i   COPY public.product_logs (id, name, price, description, inserted_on, updated_on, deleted_on) FROM stdin;
    public          postgres    false    228   ��       �          0    16505    products 
   TABLE DATA           P   COPY public.products (id, name, price, dateofcreation, description) FROM stdin;
    public          postgres    false    219   w�       �          0    16523    useraddress 
   TABLE DATA           d   COPY public.useraddress (userid, country, region, city, street, number, postalcode, id) FROM stdin;
    public          postgres    false    220   p�       �          0    16759    useraddress_logs 
   TABLE DATA           �   COPY public.useraddress_logs (userid, country, region, city, street, number, postalcode, id, inserted_on, updated_on, deleted_on) FROM stdin;
    public          postgres    false    227   ��       �          0    16471    users 
   TABLE DATA           n   COPY public.users (id, username, password, email, phonenumber, fname, lname, age, dateofcreation) FROM stdin;
    public          postgres    false    216   ]�       �          0    16748 
   users_logs 
   TABLE DATA           �   COPY public.users_logs (id, username, password, email, phonenumber, fname, lname, age, inserted_on, updated_on, deleted_on) FROM stdin;
    public          postgres    false    226   ��       �           0    0    discounts_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.discounts_id_seq', 28, true);
          public          postgres    false    221            �           0    0    orderproducts_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orderproducts_id_seq', 9, true);
          public          postgres    false    223            �           0    0    products_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.products_id_seq', 16, true);
          public          postgres    false    218            �           0    0    useraddress_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.useraddress_id_seq', 34, true);
          public          postgres    false    225            �           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 17, true);
          public          postgres    false    215            �           2606    16542    discounts discounts_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.discounts DROP CONSTRAINT discounts_pkey;
       public            postgres    false    222            �           2606    16553     orderproducts orderproducts_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.orderproducts
    ADD CONSTRAINT orderproducts_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.orderproducts DROP CONSTRAINT orderproducts_pkey;
       public            postgres    false    224            �           2606    16503    orders orders_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orderno);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    217            �           2606    16512    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    219            �           2606    16688    useraddress useraddress_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.useraddress
    ADD CONSTRAINT useraddress_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.useraddress DROP CONSTRAINT useraddress_pkey;
       public            postgres    false    220            �           2606    16479    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            �           2620    16812     discounts on_delete_discount_log    TRIGGER     �   CREATE TRIGGER on_delete_discount_log BEFORE DELETE ON public.discounts FOR EACH ROW EXECUTE FUNCTION public.log_delete_discount();
 9   DROP TRIGGER on_delete_discount_log ON public.discounts;
       public          postgres    false    222    277            �           2620    16801 )   orderproducts on_delete_orderproducts_log    TRIGGER     �   CREATE TRIGGER on_delete_orderproducts_log BEFORE DELETE ON public.orderproducts FOR EACH ROW EXECUTE FUNCTION public.log_delete_orderproducts();
 B   DROP TRIGGER on_delete_orderproducts_log ON public.orderproducts;
       public          postgres    false    224    274            �           2620    16791    orders on_delete_orders_log    TRIGGER     |   CREATE TRIGGER on_delete_orders_log BEFORE DELETE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.log_delete_order();
 4   DROP TRIGGER on_delete_orders_log ON public.orders;
       public          postgres    false    217    269            �           2620    16778    products on_delete_products_log    TRIGGER     �   CREATE TRIGGER on_delete_products_log BEFORE DELETE ON public.products FOR EACH ROW EXECUTE FUNCTION public.log_delete_product();
 8   DROP TRIGGER on_delete_products_log ON public.products;
       public          postgres    false    273    219            �           2620    16756    users on_delete_user_log    TRIGGER     �   CREATE TRIGGER on_delete_user_log BEFORE DELETE ON public.users FOR EACH ROW EXECUTE FUNCTION public.log_delete_user_changes();
 1   DROP TRIGGER on_delete_user_log ON public.users;
       public          postgres    false    216    262            �           2620    16767 %   useraddress on_delete_useraddress_log    TRIGGER     �   CREATE TRIGGER on_delete_useraddress_log BEFORE DELETE ON public.useraddress FOR EACH ROW EXECUTE FUNCTION public.log_delete_useraddress();
 >   DROP TRIGGER on_delete_useraddress_log ON public.useraddress;
       public          postgres    false    267    220            �           2620    16810     discounts on_insert_discount_log    TRIGGER     �   CREATE TRIGGER on_insert_discount_log AFTER INSERT ON public.discounts FOR EACH ROW EXECUTE FUNCTION public.log_insert_discount();
 9   DROP TRIGGER on_insert_discount_log ON public.discounts;
       public          postgres    false    222    275            �           2620    16798 )   orderproducts on_insert_orderproducts_log    TRIGGER     �   CREATE TRIGGER on_insert_orderproducts_log AFTER INSERT ON public.orderproducts FOR EACH ROW EXECUTE FUNCTION public.log_insert_orderproducts();
 B   DROP TRIGGER on_insert_orderproducts_log ON public.orderproducts;
       public          postgres    false    271    224            �           2620    16789    orders on_insert_orders_log    TRIGGER     {   CREATE TRIGGER on_insert_orders_log AFTER INSERT ON public.orders FOR EACH ROW EXECUTE FUNCTION public.log_insert_order();
 4   DROP TRIGGER on_insert_orders_log ON public.orders;
       public          postgres    false    270    217            �           2620    16774    products on_insert_products_log    TRIGGER     �   CREATE TRIGGER on_insert_products_log AFTER INSERT ON public.products FOR EACH ROW EXECUTE FUNCTION public.log_insert_product();
 8   DROP TRIGGER on_insert_products_log ON public.products;
       public          postgres    false    251    219            �           2620    16758    users on_insert_user_log    TRIGGER     w   CREATE TRIGGER on_insert_user_log AFTER INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.log_insert_user();
 1   DROP TRIGGER on_insert_user_log ON public.users;
       public          postgres    false    264    216            �           2620    16763 %   useraddress on_insert_useraddress_log    TRIGGER     �   CREATE TRIGGER on_insert_useraddress_log AFTER INSERT ON public.useraddress FOR EACH ROW EXECUTE FUNCTION public.log_insert_useraddress();
 >   DROP TRIGGER on_insert_useraddress_log ON public.useraddress;
       public          postgres    false    220    265            �           2620    16811     discounts on_update_discount_log    TRIGGER     �   CREATE TRIGGER on_update_discount_log BEFORE UPDATE ON public.discounts FOR EACH ROW EXECUTE FUNCTION public.log_update_discount();
 9   DROP TRIGGER on_update_discount_log ON public.discounts;
       public          postgres    false    276    222            �           2620    16799 )   orderproducts on_update_orderproducts_log    TRIGGER     �   CREATE TRIGGER on_update_orderproducts_log BEFORE UPDATE ON public.orderproducts FOR EACH ROW EXECUTE FUNCTION public.log_update_orderproducts();
 B   DROP TRIGGER on_update_orderproducts_log ON public.orderproducts;
       public          postgres    false    272    224            �           2620    16790    orders on_update_orders_log    TRIGGER     |   CREATE TRIGGER on_update_orders_log BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.log_update_order();
 4   DROP TRIGGER on_update_orders_log ON public.orders;
       public          postgres    false    268    217            �           2620    16776    products on_update_products_log    TRIGGER     �   CREATE TRIGGER on_update_products_log BEFORE UPDATE ON public.products FOR EACH ROW EXECUTE FUNCTION public.log_update_product();
 8   DROP TRIGGER on_update_products_log ON public.products;
       public          postgres    false    250    219            �           2620    16739    users on_update_user_log    TRIGGER     �   CREATE TRIGGER on_update_user_log BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.log_update_user_changes();
 1   DROP TRIGGER on_update_user_log ON public.users;
       public          postgres    false    249    216            �           2620    16765 %   useraddress on_update_useraddress_log    TRIGGER     �   CREATE TRIGGER on_update_useraddress_log BEFORE UPDATE ON public.useraddress FOR EACH ROW EXECUTE FUNCTION public.log_update_useraddress();
 >   DROP TRIGGER on_update_useraddress_log ON public.useraddress;
       public          postgres    false    266    220            �           2606    16554    orderproducts fk_order    FK CONSTRAINT     {   ALTER TABLE ONLY public.orderproducts
    ADD CONSTRAINT fk_order FOREIGN KEY (orderno) REFERENCES public.orders(orderno);
 @   ALTER TABLE ONLY public.orderproducts DROP CONSTRAINT fk_order;
       public          postgres    false    217    224    3294            �           2606    16543    discounts fk_product    FK CONSTRAINT     x   ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT fk_product FOREIGN KEY (productid) REFERENCES public.products(id);
 >   ALTER TABLE ONLY public.discounts DROP CONSTRAINT fk_product;
       public          postgres    false    219    3296    222            �           2606    16559    orderproducts fk_product    FK CONSTRAINT     |   ALTER TABLE ONLY public.orderproducts
    ADD CONSTRAINT fk_product FOREIGN KEY (productid) REFERENCES public.products(id);
 B   ALTER TABLE ONLY public.orderproducts DROP CONSTRAINT fk_product;
       public          postgres    false    3296    224    219            �           2606    16528    useraddress fk_user    FK CONSTRAINT     q   ALTER TABLE ONLY public.useraddress
    ADD CONSTRAINT fk_user FOREIGN KEY (userid) REFERENCES public.users(id);
 =   ALTER TABLE ONLY public.useraddress DROP CONSTRAINT fk_user;
       public          postgres    false    216    220    3292            �   �   x�m�A�@�5s
/P�Cggt���n����h��j�^>�L*���x�\�����'Щvv�W�
�(t��J��Z�fcG	я|����\��zBs"4��2�Ӹ��@����X�,��Zd�
إ��9�%*�ϔ�@'�SԌj�>�?�b�u�[DucH1h�qJ���Ks      �   /  x�}�KN�0��ur�^`"��9'`SM�Ͱ(��WH@Q���kj��� ��B� w�N\HՌfI|�
6s��,�A���;hQgk�pά�3��s���1�nP��)C(P�����b�vΰ��{TC}��+�>�y��lw���Q��Pc6:�;YcC�`э�-��b�Z�����/�)���s��iJ��~�\��v}���/���I�t9~��- �@���yx2��W�ڳ+h,����['�2W������n�)�@|����j�v���diN������ �JqϹz3�.S��s�'⠨      �   ;  x����J1��3O�/�!IӦ��^Dу��K�t@\�0>���eA$B�4z&!,M��dj��s%FD.�|wԨΒk&�JB.@�E@S�J�h�}�y��n/�`k^����� N;�Y�,:E���_r���q?%t�7�����������7�O�D����T�!Ds�Rz�OsKYX\װf�|�B^O8�qg�(�&(�&Q��1B! ���EVUZ�.[��A��_�]8�ZL�*"�F$��U� y�s��@����RT�0Tc�P)"H�
K*!Z2��.��w3ƙp"Ѹ���<���	�
�      �   h   x��ϱ�0@�v���5���!r�:7���hͦX�6Yp��%�������� ̌�������Xb��iI0Y��T�$9�fy͖'�ٙ��oR�7      �   �   x��λ1��:��p�gg&�!9n�'
N��ʟ�Hu�����?`�Шm�������� 3�F֍:S�֌-�okr\��	�.X܃T���򗪵k���?r�#P7��ѩ�pA�w��0G}����'4%�ƪZ�A�-�B��x�|/9�h6Xr      �   �  x���M�1��]���Пe�ϒ�!d�	S��quB&0�h��6~�ޓD4H� �2A��	�)�4��LFf �+�M�&�9_���U�,G��o����=J?��g�Eʨ�&4���������Z��cN�Ds�S�@�h�
Q�B�hQk�}�LY�r�԰H�-�Bm<���3�H{�Hf���&�@�5�e ��Ĕ!j2�#�dFO�4�D�S�á8In%�E� ���x�SG�����^�����}\_��xۊ�1�7X�P[{T�N���d��&~�Ǖ��|ଦ�.
�5�RK��ޅA��U���e��*��U��G��C�v^����S�����ѡR���}@�a�sΙ&��YN�.�bg��������Ws��U5	�$�4[�j~�仄g�����v�	9��<��P5��s��Gβ;�g8����/��m�      �   �   x�m�M
�@�u���!�ɘ�!z7SW��?TD�h!��G���| C[j�@H�c�$n�E�B�a6D��N�X������������f�>[r &huj�/)鍥�cd2�[��k�� �����8��5�M$|�xĔ�h\@�      �   �   x����m�0E��^�IQ�:C/��)��
x��N�n�%y|�����X�02�D=SG�}�-%�`<�M�%A��m͑�}�d�#� �t[M|��tɪWn���<V��$̨�JSuPǡ�X�O$3ZM���|���*���e�e��P�S\7qn�Ȓz���~�ҝ˽;��T�[Y�\^o���cG!��W���m(�2\�gzܣt���+�gN��ޫ5�|��v-      �   /   x�34�<����sS�-FaL97Ɵ�iRdlhdbh�il����� uA�      �   �   x�}�A
�0EדS��3�4�^�M���� x�Bo���LVQ�*�,�����9�2���@LB
%b�\5�$�&�Z���Эg��]'xL�[Ā-���q�?��ǗF]Ro5:�h T�2��,�0���'z��X��։��|Lp6Hh�?��1�GzG�      �   a   x���!�0P��� �_H&�-�����I������#����G`�@���,M�����͕ru_�1��m~^�����T���7�����      �   �   x���=n�0Fg�����~�6k:v�"@;IQ��+����AS��{�H:�c��F�����4B+�02wD�q"�u�`�ZW�Ѕ�`����9��xa���dȥB�(��MBI��E�<�[>�í��k���- Jd������M��Z-�"�Jsؿ>�<�(�Z��(��~�_��f�͢03��tM�F$����а�XI5���̊��|)����g�
�w���Z)�	E���     