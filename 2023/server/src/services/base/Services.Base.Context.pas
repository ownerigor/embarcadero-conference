unit Services.Base.Context;

interface

uses System.JSON, Web.HTTPApp, System.Generics.Collections;

type
  IServiceBaseContext = interface
    ['{FD4FD25A-0E36-4FE9-95E5-80FAFF062A6D}']
    function Payload: TJSONObject;
    function WebRequest: TWebRequest;
    function QueryParams: TDictionary<string, string>;
    function Headers: TDictionary<string, string>;
    function LoggedUser: string;
    function Authorization: string;
  end;

implementation

end.
