class Constants{
   static const  String fetchHistoryUrl = "https://stem.ubidots.com/api/v1.6/variables/$variableId/values";
   static const  String fetchLastValueUrl = "https://industrial.api.ubidots.com/api/v1.6/devices/$deviceLabel/$variableLabel/lv";
   static const  String variableId = "623aecb638780676749e65cd";
   static const  String deviceLabel = "esp32";
   static const  String variableLabel = "uv";
   static const  String token = "BBFF-aar8vW6b2czwDqBPGlPLKQYUcQaj80";

   static const double dangerValue = 5.14;
}