
#!/bin/bash
#set -xe

# Code generated by https://github.com/awalterschulze/git-anchor
# source: src/github.com/gogo/letmegrpc
# DO NOT EDIT!

function subtreerev {
	git log | grep -E "(git-subtree-dir: $1|git-subtree-split)" | grep $1 -A 1 | grep git-subtree-split | head -1 | tr -d ' ' | cut -d ":" -f2
}

function subtrees {
	git log | grep git-subtree-dir | tr -d ' ' | cut -d ":" -f2 | sort | uniq | xargs -I {} bash -c 'if [ -d $(git rev-parse --show-toplevel)/{} ] ; then echo {}; fi'
}

function clonerev {
	(cd $1 && git log -1 | head -1 | cut -d " " -f2 )
}

function checkdep {
	dir=$1
	repo=$2
	rev=$3
	echo "checking dependency $dir $repo $rev"
	if [ ! -d $dir ]; then
		if `git rev-parse --is-inside-work-tree`
		then
			echo "ERROR: This is a git repo, but $dir does not exist."
			echo "       You could add a subtree like so:"
			echo "       $ git subtree add --prefix=$dir $repo master"
			exit 1
		else
			mkdir -p $dir
			git clone $repo $dir
			(cd $dir && git checkout $rev)
		fi
	else
		if [ -e $dir/.git ]; then
			echo "found git repo at $dir"
			crev=$(clonerev $dir)
			if [ $crev == $rev ]; then
				echo "git clone $dir is the correct revision"
			else
				echo "WARNING: git clone $dir is revision $crev, but correct version is $rev"
			fi
		else
			ss=$(subtrees)
			if [[ $ss == *"$dir"* ]]; then
				echo "found subtree at $dir"
				srev=$(subtreerev $dir)
				if [ $srev == $rev ]; then
					echo "git subtree $dir is the correct revision"
				else
					echo "WARNING: git subtree (Please ignore this warning if your subtree is not squashed) $dir is revision $srev, but correct version is $rev. "
				fi
			else
				echo "WARNING: $dir exists, but is not git repo or git subtree"
			fi
		fi
	fi
}


if [ ! -d src/github.com/gogo/letmegrpc ]; then
	echo "ERROR: src/github.com/gogo/letmegrpc does not exist, maybe you are running this script from the wrong folder."
	exit 1
fi


checkdep src/github.com/gogo/protobuf https://github.com/gogo/protobuf 6cab0cc9fec8f660c2cee46e1306ffc727261956


checkdep src/google.golang.org/grpc https://github.com/grpc/grpc-go 868330046b32ec2d0e37a3d8d8cdacff14f32555


checkdep src/golang.org/x/net https://github.com/golang/net ea47fc708ee3e20177f3ca3716217c4ab75942cb


checkdep src/github.com/bradfitz/http2 https://github.com/bradfitz/http2 f8202bc903bda493ebba4aa54922d78430c2c42f


checkdep src/github.com/golang/glog https://github.com/golang/glog fca8c8854093a154ff1eb580aae10276ad6b1b5f


checkdep src/github.com/golang/protobuf https://github.com/golang/protobuf 6dfb160b2754e3b3fa583fbd0c207dfab2e836e5


checkdep src/golang.org/x/oauth2 https://github.com/golang/oauth2 397fe7649477ff2e8ced8fc0b2696f781e53745a


checkdep src/google.golang.org/cloud https://code.googlesource.com/gocloud 43ba5cf9407286f5430bfb3ea6f2e008a9a9f14b



exit 0
