import '../Data/machine.dart';

class MachineListState {
  final Map<String, List<Machine>> categories = {
    'Tempering': [
      Machine(
        name: 'SELMI ONE',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/GxfzY2k/selmi-one-chocolate-tempering-machine.png',
        description: 'Advanced chocolate processing machine',
      ),
      Machine(
        name: 'LEGEND',
        productionYear: '2021',
        imageUrl: 'https://i.ibb.co/hyNW11v/legend-chocolate-tempering-machine.png',
        description: 'Specialized truffle making machine',
      ),
      Machine(
        name: 'CENTO',
        productionYear: '2023',
        imageUrl: 'https://i.ibb.co/PM6nJzC/cento-chocolate-tempering-machine.png',
        description: 'Master chocolate processing unit',
      ),
    ],
    'Chocolate Enrobing Machines': [
      Machine(
        name: 'RS200',
        productionYear: '2020',
        imageUrl: 'https://i.ibb.co/Jdc0m4m/chocolate-enrobing-machine-rs200.png',
        description: 'Small capacity coating line',
      ),
      Machine(
        name: 'Truffle',
        productionYear: '2021',
        imageUrl: 'https://i.ibb.co/LQ2gQFR/chocolate-coating-machine-truffle-p.png',
        description: 'Medium capacity coating line',
      ),
      Machine(
        name: 'R600t',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/yd3Yx8V/chocolate-coating-belt-r600t.png',
        description: 'Large capacity coating line',
      ),
    ],
    'Chocolate Moulding': [
      Machine(
        name: 'Automatic Demoulder',
        productionYear: '2023',
        imageUrl: 'https://i.ibb.co/YLcvjjN/chocolate-automatic-demoulder.png',
        description: 'Premium tempering machine',
      ),
      Machine(
        name: 'Injection Plate',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/X4nV919/chocolate-injection-plate.png',
        description: 'Advanced tempering machine',
      ),
      Machine(
        name: 'Galileo',
        productionYear: '2021',
        imageUrl: 'https://i.ibb.co/m9Jz437/galileo-chocolate-hollow-bodies.png',
        description: 'Dual-channel tempering machine',
      ),
    ],
    'Chocolate Enrobing, Moulding, and Cooling Tunnels': [
      Machine(
        name: 'Spider',
        productionYear: '2023',
        imageUrl: 'https://i.ibb.co/Lzhd93r/spider-vertical-chocolate-cooling-tunnel.png',
        description: 'Premium tempering machine',
      ),
      Machine(
        name: 'Tunnel 200/250mm',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/2sdqFqc/chocolate-enrobing-cooling-tunnel-200-250.png',
        description: 'Advanced tempering machine',
      ),
      Machine(
        name: 'Drops System',
        productionYear: '2021',
        imageUrl: 'https://i.ibb.co/njwZ46m/chocolate-drops-system.png',
        description: 'Dual-channel tempering machine',
      ),
    ],
    'One Shot Tuttuno': [
      Machine(
        name: 'One Shot Tuttuno 9',
        productionYear: '2023',
        imageUrl: 'https://i.ibb.co/rpW7NYG/tuttuno-oneshot9-chocolate-depositor-machine.png',
        description: 'Premium tempering machine',
      ),
      Machine(
        name: 'Tuttuno Mould Loader',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/y478Z25/mould-loader-oneshot-tuttuno.png',
        description: 'Advanced tempering machine',
      ),
      Machine(
        name: 'Vibra',
        productionYear: '2021',
        imageUrl: 'https://i.ibb.co/smF39LM/vibra-chocolate-moulds-vibrator-oneshot-tuttuno.png',
        description: 'Dual-channel tempering machine',
      ),
    ],
    'Clusters': [
      Machine(
        name: 'Clusters Tunnel',
        productionYear: '2023',
        imageUrl: 'https://i.ibb.co/DDVjhfP/clusters-chocolate-nuts.png',
        description: 'Premium tempering machine',
      ),
      Machine(
        name: 'Clusters Teglia',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/rmFRhvr/clusters-teglia-chocolate-nuts.png',
        description: 'Advanced tempering machine',
      ),
    ],
    'Chocolate Panning Machines': [
      Machine(
        name: 'Comfit',
        productionYear: '2023',
        imageUrl: 'https://i.ibb.co/fpp0sjs/comfit-maxi-chocolate-panning-machine.png',
        description: 'Premium tempering machine',
      ),
      Machine(
        name: 'Comfit Maxi',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/0Zfzrtr/comfit-chocolate-panning-machine.png',
        description: 'Advanced tempering machine',
      ),
      Machine(
        name: 'Spraysystem',
        productionYear: '2021',
        imageUrl: 'https://i.ibb.co/G0y5kv1/chocolate-coating-spray-system.png',
        description: 'Dual-channel tempering machine',
      ),
    ],
    'Chocolate Melters and Mixers': [
      Machine(
        name: 'Tank 200',
        productionYear: '2023',
        imageUrl: 'https://i.ibb.co/7grjp1b/tank200-chocolate-mixer-melter.png',
        description: 'Premium tempering machine',
      ),
      Machine(
        name: 'Tank 400',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/WsNScx4/tank400-chocolate-mixer-melter.png',
        description: 'Advanced tempering machine',
      ),
    ],
    'Chocolate Extruders': [
      Machine(
        name: 'Chocoform',
        productionYear: '2023',
        imageUrl: 'https://i.ibb.co/8Y6csVq/chocoform-chocolate-products-extruder.png',
        description: 'Premium tempering machine',
      ),
      Machine(
        name: 'Chocoliner',
        productionYear: '2022',
        imageUrl: 'https://i.ibb.co/2N9Fmcz/chocoliner-chocolate-aligner.png',
        description: 'Advanced tempering machine',
      ),
      Machine(
        name: 'Extruder',
        productionYear: '2021',
        imageUrl: 'https://i.ibb.co/CmmN7tq/continuous-linear-extruder.png',
        description: 'Dual-channel tempering machine',
      ),
    ],
  };
}