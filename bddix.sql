--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)
select * from potion;

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)
select* from categorie where nb_points=3;

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)
select*
from village where nb_huttes >35;

--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)
select*
from trophee where date_prise between '2052-05-05' and '2052-06-06';

--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)
select * from habitant  where nom  like 'A%r%';

--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)
select num_hab  from absorber where num_potion IN (1, 3, 4) group by num_hab ;

--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)
select t.num_trophee, t.date_prise, c.nom_categ,h.nom
from trophee t
join categorie c on c.code_cat = t.code_cat 
join habitant h on t.num_preneur=h.num_hab;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)
select h.nom
from village v 
join habitant h  on v.num_village = h.num_village 
where nom_village = 'Aquilona';

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
select h.nom
from habitant h 
inner join trophee t on h.num_hab = t.num_preneur 
inner join categorie c on t.code_cat = c.code_cat 
where nom_categ ='Bouclier de Légat';

--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)
select p.lib_potion, p.formule , p.constituant_principal 
from potion p 
inner join fabriquer f on p.num_potion = f.num_potion 
inner join habitant h on f.num_hab = h.num_hab 
where nom = 'Panoramix';

--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)
select p.lib_potion
from potion p 
inner join absorber a on p.num_potion = a.num_potion 
inner join habitant h on a.num_hab = h.num_hab 
where nom = 'Homéopatix'
group by lib_potion;
--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)
select h.nom
from habitant h 
inner join absorber a on h.num_hab = a.num_hab 
inner join potion p on a.num_potion = p.num_potion 
inner join fabriquer f on p.num_potion = f.num_potion 
where  f.num_hab = 3
group by nom;

--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)
select distinct  h.nom
from habitant h 
inner join absorber a on h.num_hab = a.num_hab 
inner join fabriquer f on a.num_potion = f.num_potion
inner join habitant h2 on h2.num_hab = f.num_hab 
where h2.nom ='Amnésix';
--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)

select h.nom 
from habitant h 
where h.num_qualite is null;


--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)

select h.nom 
from habitant h
inner join absorber a on a.num_hab= h.num_hab 
inner join potion p on a.num_potion = p.num_potion
where p.lib_potion = 'Potion magique n°1' and  a.date_a between  '2052-02-01' and '2052-02-20';


--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)

select h.nom, h.age
from habitant h
order by nom;

--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)

select r.nom_resserre, v.nom_village
from resserre r
inner join village v on v.num_village = r.num_village 
order by nom_resserre;


--***

--18. Nombre d'habitants du village numéro 5. (4)

select count(*) as nb_Habitant
from habitant h 
where h.num_village = 5;

--19. Nombre de points gagnés par Goudurix. (5)

select sum(c.nb_points)
from categorie c 
inner join trophee t on c.code_cat= t.code_cat 
inner join habitant h on t.num_preneur= h.num_hab 
where h.nom = 'Goudurix';

--20. Date de première prise de trophée. (03/04/52)

 select min(date_prise)
 from trophee t 
 


--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)
 
 select sum(a.quantite)
 from absorber a 
 inner join potion p on a.num_potion = p.num_potion 
 where p.lib_potion = 'Potion magique n°2';

--22. Superficie la plus grande. (895)

select max(superficie) 
from resserre r;

--***

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)

select v.nom_village,  count(h.num_hab)
from habitant h 
inner join village v on h.num_village = v.num_village
group by v.nom_village;

--24. Nombre de trophées par habitant (6 lignes)
select h.nom, count(t.num_trophee)
from trophee t 
inner join habitant h on h.num_hab = t.num_preneur 
group by h.nom;


--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)

select p.nom_province, avg(h.age)
from habitant h  
inner join village v on h.num_village= v.num_village 
inner join province p on v.num_province = p.num_province 
group by p.nom_province;

--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)

select h.nom, count(p.lib_potion)
from habitant h 
inner join absorber a on h.num_hab= a.num_hab
inner join potion p on a.num_potion = p.num_potion
group by h.nom;


--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)

select h.nom
from habitant h 
inner join absorber a on h.num_hab=a.num_hab
inner join potion p on a.num_potion = p.num_potion
where a.quantite > 2 and p.lib_potion = 'Potion Zen'
group by h.nom;


--***
--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)

select v.nom_village
from village v 
inner join resserre r on v.num_village = r.num_village; 


--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)

select  v.nom_village 
from village v 
order by v.nb_huttes desc limit 1;

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).

select h.nom, count(t.num_trophee)
from habitant h
inner join trophee t on h.num_hab = t.num_preneur
group by h.nom 
having count(t.num_trophee) > 
(select count(num_trophee)
from trophee 
where num_preneur = 
(select num_hab 
from habitant 
where nom = 'Obélix'));
