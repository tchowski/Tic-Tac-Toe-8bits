# i18n

Les wordings se trouvent dans ce module.

## usage

Il suffit de mettre à jours le fichier lib/l10n/intl_fr.arb, le plugin Flutter Intl regénére les fichiers dart.

Pour une génération manuelle (depuis le répertoire i18n) :
flutter pub run intl_utils:generate
>> ne générera que les fichiers mobile
>> à n'utiliser que pendant les devs (plus rapide) mais avant de pusher, il faudra utiliser la commande suivante

Ou alors dans medias/connect/mobile (mobile et web) (depuis le répertoire medias/connect/mobile) :
../../../bin/flutter-codegen-update
>> générera les fichiers mobile et web
>> /!\ REQUIS par la CI (mobile et web doivent être iso)

Si on ajout le --all il va générer les routes avec :
../../../bin/flutter-codegen-update --all


## format des clés

Voir le wiki : https://wiki.vsct.fr/display/IVTS/Internationalisation
