pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/access/Ownable.sol";

contract x4dm_generate_a_dece {
    using Counters for Counters.Counter;
    using SafeERC20 for IERC20;

    // Mapping of pipeline integrations
    mapping(address => mapping(string => bytes)) public pipelineIntegrations;

    // Mapping of pipeline configurations
    mapping(address => mapping(string => Config)) public pipelineConfigs;

    // Event emitted when a new pipeline integration is created
    event PipelineIntegrationCreated(address indexed owner, string pipelineName, bytes integrationData);

    // Event emitted when a pipeline configuration is updated
    event PipelineConfigUpdated(address indexed owner, string pipelineName, Config config);

    // Struct to represent a pipeline configuration
    struct Config {
        uint256 version;
        bytes data;
    }

    // Only allow the contract owner to create pipeline integrations
    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can create pipeline integrations");
        _;
    }

    // Create a new pipeline integration
    function createPipelineIntegration(string memory pipelineName, bytes memory integrationData) public onlyOwner {
        pipelineIntegrations[msg.sender][pipelineName] = integrationData;
        emit PipelineIntegrationCreated(msg.sender, pipelineName, integrationData);
    }

    // Update a pipeline configuration
    function updatePipelineConfig(string memory pipelineName, Config memory config) public {
        pipelineConfigs[msg.sender][pipelineName] = config;
        emit PipelineConfigUpdated(msg.sender, pipelineName, config);
    }

    // Get a pipeline integration
    function getPipelineIntegration(address owner, string memory pipelineName) public view returns (bytes memory) {
        return pipelineIntegrations[owner][pipelineName];
    }

    // Get a pipeline configuration
    function getPipelineConfig(address owner, string memory pipelineName) public view returns (Config memory) {
        return pipelineConfigs[owner][pipelineName];
    }
}