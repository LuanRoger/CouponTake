using System.Text;

namespace CuponTakeInfra.Auth.Services.Security;

public sealed class RelatedInformation
{
    private List<string> _informations { get; } = new();
    
    private bool _cacheExpires { get; set; }
    private string _cachedResult { get; set; }

    public RelatedInformation()
    {
        _cachedResult = string.Empty;
        _cacheExpires = true;
    }
    
    public void AddInformation(string info)
    {
        _informations.Add(info);
        _cacheExpires = true;
    }

    public override string ToString()
    {
        if(!_cacheExpires) return _cachedResult;

        StringBuilder builder = new();
        foreach (string information in _informations)
            builder.Append(information);
        
        string result = builder.ToString();
        SetCache(result);
        
        return result;
    }
    
    private void SetCache(string cache)
    {
        _cachedResult = cache;
        _cacheExpires = false;
    }
}