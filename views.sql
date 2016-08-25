-------------------------------------------------------------------------------
-- Create a view to output all active woocommerce orders
-- using wp_posts and woocommerce tables
-------------------------------------------------------------------------------
  CREATE VIEW `md_id_orderitemnum_subnumber_1`
AS
  SELECT    `p`.`id`              AS `oi order id (same as posts.id)`,
            `oi`.`order_item_id`  AS `oi order item id`,
            `oim`.`order_item_id` AS `oim order item id`,
            `m1`.`meta_value`     AS `submission number (fou)`
  FROM(((`wp_posts` `p`
        LEFT JOIN `wp_woocommerce_order_items` `oi` ON (( `p`.`id` = `oi`.`order_id`)))
        LEFT JOIN `wp_woocommerce_order_itemmeta` `oim` ON (( `oi`.`order_item_id` = `oim`.`order_item_id`)))
        LEFT JOIN `wp_woocommerce_order_itemmeta` `m1` ON (( `oi`.`order_item_id` = `m1`.`order_item_id`)))
  WHERE (( `p`.`post_type` LIKE 'shop_order')
        AND ( NOT(( `p`.`post_status` LIKE 'trash')))
        AND ( `m1`.`meta_key` = 'For Office Use'))
  GROUP BY  `m1`.`meta_value`
  ORDER BY  `p`.`id` ;
-------------------------------------------------------------------------------
-- Create a View to get the submission number,
-- submission metadata and order attributes
-------------------------------------------------------------------------------
  CREATE VIEW `md_final_report_to_lastname_2`
AS
  SELECT    `v`.`oi order id (same as posts.id)` AS `order #`,
            `v`.`submission number (fou)`        AS `submission #`,
            `m0`.`meta_value`                    AS `packing slip piece #`,
            `m1`.`meta_value`                    AS `address`,
            `m2`.`meta_value`                    AS `title of entry`,
            `m3`.`meta_value`                    AS `category`,
            `m4`.`meta_value`                    AS `press type`,
            `m5`.`meta_value`                    AS `additional information`,
            `m6`.`meta_value`                    AS `award won - empty`,
            `m7`.`meta_value`                    AS `judges comments - empty`,
            `m8`.`meta_value`                    AS `company`,
            `m9`.`meta_value`                    AS `first name`,
            `m10`.`meta_value`                   AS `last name`
FROM (((((((((((`md_woo_oi_oim_id_orderidnum_subnumber_1_v2` `v`
        LEFT JOIN `wp_postmeta` `m0` ON (( `v`.`submission number (fou)` = `m0`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m1` ON (( `v`.`submission number (fou)` = `m1`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m2` ON (( `v`.`submission number (fou)` = `m2`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m3` ON (( `v`.`submission number (fou)` = `m3`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m4` ON (( `v`.`submission number (fou)` = `m4`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m5` ON (( `v`.`submission number (fou)` = `m5`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m6` ON (( `v`.`submission number (fou)` = `m6`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m7` ON (( `v`.`submission number (fou)` = `m7`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m8` ON (( `v`.`oi order id (same as posts.id)` = `m8`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m9` ON (( `v`.`oi order id (same as posts.id)` = `m9`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m10` ON (( `v`.`oi order id (same as posts.id)` = `m10`.`post_id`)))
WHERE (( `m0`.`meta_key` = '_seq_num')
        AND ( `m1`.`meta_key` = '_field_40')
        AND ( `m2`.`meta_key` = '_field_43')
        AND ( `m3`.`meta_key` = '_field_44')
        AND ( `m4`.`meta_key` = '_field_45')
        AND ( `m5`.`meta_key` = '_field_48')
        AND ( `m6`.`meta_key` = '_field_62')
        AND ( `m7`.`meta_key` = '_field_63')
        AND ( `m8`.`meta_key` = '_billing_company')
        AND ( `m9`.`meta_key` = '_billing_first_name')
        AND ( `m10`.`meta_key` = '_billing_last_name'));
-----------------------------------------------------------------------------------------
-- View to produce all of the final submission 
-- and order data with the packing slip info
-----------------------------------------------------------------------------------------
 CREATE VIEW `md_all_for_final_report_3`
AS
  SELECT    `v`.`order #`                 AS `order #`,
            `v`.`submission #`            AS `submission #`,
            `v`.`packing slip piece #`    AS `packing slip piece #`,
            `v`.`address`                 AS `address`,
            `v`.`title of entry`          AS `title of entry`,
            `v`.`category`                AS `category`,
            `v`.`press type`              AS `press type`,
            `v`.`additional information`  AS `additional information`,
            `v`.`award won - empty`       AS `award won - empty`,
            `v`.`judges comments - empty` AS `judges comments - empty`,
            `v`.`company`                 AS `company`,
            `v`.`first name`              AS `first name`,
            `v`.`last name`               AS `last name`,
            `m11`.`meta_value`            AS `address 1`,
            `m12`.`meta_value`            AS `address 2`,
            `m13`.`meta_value`            AS `city`,
            `m14`.`meta_value`            AS `state`,
            `m15`.`meta_value`            AS `zip`,
            `m16`.`meta_value`            AS `country`
FROM ((((((`md_final_packard_report_v1_lastname` `v`
        LEFT JOIN `wp_postmeta` `m11` ON (( `v`.`order #` = `m11`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m12` ON (( `v`.`order #` = `m12`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m13` ON (( `v`.`order #` = `m13`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m14` ON (( `v`.`order #` = `m14`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m15` ON (( `v`.`order #` = `m15`.`post_id`)))
        LEFT JOIN `wp_postmeta` `m16` ON (( `v`.`order #` = `m16`.`post_id`)))
WHERE (( `m11`.`meta_key` = '_billing_address_1')
       AND ( `m12`.`meta_key` = '_billing_address_2')
       AND ( `m13`.`meta_key` = '_billing_city')
       AND ( `m14`.`meta_key` = '_billing_state')
       AND ( `m15`.`meta_key` = '_billing_postcode')
       AND ( `m16`.`meta_key` = '_billing_country'));
--------------------------------------------------------------------------------------
-- That's all
-- Folks
--------------------------------------------------------------------------------------
